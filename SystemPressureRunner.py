from ATScripts.ATSrc.ATImpl.ATAcutor.BaseTestCase import CATBaseCase
from ATScripts import ATAPI as AT
from customLib.common.CommandExcutor import CommandExcutor
from customLib.common.FileUtil import FileUtil
from customLib.common.TimeUtil import TimeUtil
from customLib.constant.Constant import Constant
from customLib.constant.EventConstant import EventConstant
from customLib.cluster.MessageSender import ClusterModule
from customLib.event.EventEmitter import EventEmitter
from customLib.loggers.modules.display.DisplayLogger import DisplayLogger
from customLib.loggers.UsbLogger import UsbLogger
from customLib.loggers.system.VipSocHeart import VipSocHeart
from customLib.opencv.Camera import VideoRecorderTask
from customLib.performance.BaseScenarioRunner import BaseScenarioRunner
from customLib.performance.system_pressure.ClusterFunctionThread import ClusterFunctionThread
from customLib.performance.system_pressure.ExceptionChecker import ExceptionChecker
from customLib.ssh.SshClient import SshClient
from customLib.performance.MonkeyMonitor import MonkeyMonitor
from customLib.performance.system_pressure.SystemServiceChecker import SystemServiceChecker

import sys
import time

HIGH_PRESSURE_FOLDER = "system_high_pressure"
CASE_PATH = Constant.MEMORY_CPU_PATH + HIGH_PRESSURE_FOLDER

START_DUMP_SCRIPT_CMD = "sh /var/dumpLogs.sh"

PULL_OUT_COREDUMP_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/coredumps {}"
PULL_OUT_HAM_COREDUMP_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/ham_coredumps {}"
PULL_OUT_ERROR_MEMORY_LOG_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/errmemlog {}"
PULL_OUT_MISC_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/misc {}"
PULL_OUT_DLT_RAW_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/dlt_raw {}"
PULL_OUT_DUMP_LOGS_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/ota_update/qnx_misc_dump {}"
PULL_OUT_PERSIST_EM_FOLDER_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/persist/em {}"

GENERATE_MINI_DUMP_CMD = "ssh -o StrictHostKeyChecking=no root@192.168.211.100 /bin/log_collector"
PULL_OUT_MINI_DUMP_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/sbldump.bin {}"
DELETE_REMOTE_MINI_DUMP_CMD = 'ssh -o StrictHostKeyChecking=no root@192.168.211.100 "rm -rf /var/log/sbldump.bin"'

EXECUTE_INC_LOG_CMD = 'ssh -o StrictHostKeyChecking=no root@192.168.211.100 "inc_logger --tx_channel 0 --rx_channel 0 --log_duration 5 --log_file /var/log/inc_log.txt"'
PULL_OUT_INC_LOG_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/inc_log.txt {}"
DELETE_REMOTE_INC_CMD = 'ssh -o StrictHostKeyChecking=no root@192.168.211.100 "rm -rf /var/log/inc_log.txt"'

EXECUTE_EM_TRACE_CMD = 'ssh -o StrictHostKeyChecking=no root@192.168.211.100 "em_trace -f /var/log/em_trace.txt"'
PULL_OUT_EM_TRACE_CMD = "scp -o StrictHostKeyChecking=no -r root@192.168.211.100:/var/log/em_trace.txt {}"
DELETE_REMOTE_EM_TRACE_CMD = 'ssh -o StrictHostKeyChecking=no root@192.168.211.100 "rm -rf /var/log/em_trace.txt"'

GET_IVI_DATETIME_CMD = "adb shell date"
SET_STRESS_AUTOMATION_PROPERTY_CMD = "adb shell setprop test.automation.stress {}"
GET_STRESS_AUTOMATION_PROPERTY_CMD = "adb shell getprop test.automation.stress"

MONKEY_RUN_TIMES = 19000  # about 2 hours
PULL_OUT_LOGS_TIMEOUT_DEFAULT = 60  # 60 secs
PULL_OUT_DLT_TIMEOUT = 2000  # 2000 secs
MINI_DUMP_TIMEOUT = 3000  # 3000 secs
EXECUTE_INC_LOG_CMD_TIMEOUT = 30  # 30 secs
CASE_DURATION = 3600 * 24 * 3  # 3 days

CAMERA_INDEX = "1"
CAMERA_RECORD_DURATION = "20"  # 20 minutes
CAMREA_API_TIMEOUT = "5"  # 5 secs

START_MONKEY = True
SINGLE_APP_MONKEY_PACKAGE_ACTIVITY = None


class testApp(CATBaseCase, BaseScenarioRunner):

    def __init__(self):
        self._isFinish = False
        self._telltaleTask = self._warningTask = None
        self._adasTask = self._guageTask = self._carModelTask = None
        self._ambientLightTask = self._chimeTask = None
        self._videoRecordTask = None
        self._expChecker = None
        self._monkeyMonitor = None
        self._vipSocHeart = None
        self._sysServiceChecker = None

    def info(self):
        # updated : 2023-07-14 09:27:58
        pass

    def startMonkeyTest(self, packageActivity=None):
        self._monkeyMonitor = MonkeyMonitor(monkeyLogFolder=CASE_PATH, packageActivity=packageActivity)
        self._monkeyMonitor.start()

    def stopMonkeyTest(self):
        if self._monkeyMonitor is not None:
            self._monkeyMonitor.stopTask()
            self._monkeyMonitor = None

    def startClusterFunctions(self):
        # telltale functions
        self._telltaleTask = ClusterFunctionThread(ClusterModule.Telltale.value)
        self._telltaleTask.start()
        # warning functions
        self._warningTask = ClusterFunctionThread(ClusterModule.Warning.value)
        self._warningTask.start()
        # guage functions
        self._guageTask = ClusterFunctionThread(ClusterModule.Guage.value)
        self._guageTask.start()
        # adas functions
        self._adasTask = ClusterFunctionThread(ClusterModule.Adas.value)
        self._adasTask.start()
        # car model functions
        # self._carModelTask = ClusterFunctionThread(ClusterModule.CarModel.value)
        # self._carModelTask.start()
        # ambient light functions
        self._ambientLightTask = ClusterFunctionThread(ClusterModule.AmbientLight.value)
        self._ambientLightTask.start()
        # chime functions
        self._chimeTask = ClusterFunctionThread(ClusterModule.Chime.value)
        self._chimeTask.start()

    def stopClusterFunctions(self):
        if self._telltaleTask is not None:
            self._telltaleTask.stopTask()
            self._telltaleTask = None
        if self._warningTask is not None:
            self._warningTask.stopTask()
            self._warningTask = None
        if self._adasTask is not None:
            self._adasTask.stopTask()
            self._adasTask = None
        if self._guageTask is not None:
            self._guageTask.stopTask()
            self._guageTask = None
        if self._carModelTask is not None:
            self._carModelTask.stopTask()
            self._carModelTask = None
        if self._ambientLightTask is not None:
            self._ambientLightTask.stopTask()
            self._ambientLightTask = None
        if self._chimeTask is not None:
            self._chimeTask.stopTask()
            self._chimeTask = None

    def dumpQnxLogs(self):
        qnxLogFolder = FileUtil.generateAbsPath(CASE_PATH, "qnx_log")
        FileUtil.createFolder(qnxLogFolder)
        # pull out ham coredumps
        CommandExcutor.excute(PULL_OUT_HAM_COREDUMP_CMD.format(qnxLogFolder), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # pull out coredumps
        CommandExcutor.excute(PULL_OUT_COREDUMP_CMD.format(qnxLogFolder), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # pull out errmemlog
        CommandExcutor.excute(PULL_OUT_ERROR_MEMORY_LOG_CMD.format(qnxLogFolder), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # pull out misc
        CommandExcutor.excute(PULL_OUT_MISC_CMD.format(qnxLogFolder), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # pull out /persist/em/ folder
        CommandExcutor.excute(PULL_OUT_PERSIST_EM_FOLDER_CMD.format(qnxLogFolder), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # pull out dlt_raw
        CommandExcutor.excute(PULL_OUT_DLT_RAW_CMD.format(qnxLogFolder), timeout=PULL_OUT_DLT_TIMEOUT)

    def dumpMiniDumpLog(self):
        CommandExcutor.excute(GENERATE_MINI_DUMP_CMD, timeout=MINI_DUMP_TIMEOUT)
        CommandExcutor.excute(PULL_OUT_MINI_DUMP_CMD.format(CASE_PATH), timeout=MINI_DUMP_TIMEOUT)
        CommandExcutor.excute(DELETE_REMOTE_MINI_DUMP_CMD, timeout=MINI_DUMP_TIMEOUT)

    def recordExceptionTime(self, file):
        try:
            iviDateTime = TimeUtil.getAndroidTimeStamp()
            qnxDateTime = TimeUtil.getQnxDateTime()
            localDateTime = TimeUtil.getCurrentDateTime()

            content = f"iviDateTime: {iviDateTime}\nqnxDateTime: {qnxDateTime}\nlocalDateTime: {localDateTime}"
            FileUtil.writeFile(file, content)
        except Exception as exp:
            AT.LogInfo(f"recordExceptionTime caught exp: {exp}")

    def getIncLogs(self):
        try:
            AT.LogInfo("start inc log...")
            CommandExcutor.excute(EXECUTE_INC_LOG_CMD, timeout=EXECUTE_INC_LOG_CMD_TIMEOUT)
            AT.LogInfo("end inc log...")
            CommandExcutor.excute(PULL_OUT_INC_LOG_CMD.format(CASE_PATH), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
            CommandExcutor.excute(DELETE_REMOTE_INC_CMD)
        except Exception as exp:
            AT.LogInfo(f"getIncLogs caught exp: {exp}")

    def getEmTrace(self):
        try:
            AT.LogInfo("start em trace...")
            CommandExcutor.excute(EXECUTE_EM_TRACE_CMD)
            AT.LogInfo("end em trace...")
            time.sleep(5)
            CommandExcutor.excute(PULL_OUT_EM_TRACE_CMD.format(CASE_PATH), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
            CommandExcutor.excute(DELETE_REMOTE_EM_TRACE_CMD)
        except Exception as exp:
            AT.LogInfo(f"getEmTrace caught exp: {exp}")

    def onExceptionFinish(self):
        AT.LogInfo("onExceptionFinish start")
        self.stopExceptionChecker()
        self.stopClusterFunctions()
        self.stopMonkeyTest()
        self.recordExceptionTime(FileUtil.generateAbsPath(CASE_PATH, "exception_datetime"))
        # trigger inc_logger
        self.getIncLogs()
        # trigger em trace
        self.getEmTrace()
        # execute dumpLogs.sh and pull out log
        SshClient.getInstance().execSshCommand(START_DUMP_SCRIPT_CMD, False)
        time.sleep(30)
        AT.LogInfo("start pull out qnx dump logs")
        CommandExcutor.excute(PULL_OUT_DUMP_LOGS_CMD.format(CASE_PATH), timeout=PULL_OUT_LOGS_TIMEOUT_DEFAULT)
        # trigger display logs
        DisplayLogger.getInstance().startLog(CASE_PATH, asyncMode=False)
        # wait 1 minute
        time.sleep(60)
        self.stopRecordVideo()
        self.onFinish()
        # pull out qnx logs
        AT.LogInfo("start pull out qnx logs")
        self.dumpQnxLogs()
        # pull out mini_dump log
        AT.LogInfo("start pull out mini_dump log")
        self.dumpMiniDumpLog()
        # trigger usblog
        AT.LogInfo("start pull out usblogs")
        UsbLogger.getInstance().startDump()
        AT.LogInfo("onExceptionFinish end")

    def startExceptionChecker(self, module):
        self._expChecker = ExceptionChecker(module=module)
        self._expChecker.start()

    def stopExceptionChecker(self):
        if self._expChecker is not None:
            self._expChecker.stopTask()
            self._expChecker = None

    def startSystemServiceChecker(self):
        self._sysServiceChecker = SystemServiceChecker(CASE_PATH)
        self._sysServiceChecker.start()

    def stopSystemServiceChecker(self):
        if self._sysServiceChecker is not None:
            self._sysServiceChecker.stopTask()
            self._sysServiceChecker = None

    def startRecordVideo(self, videoPath):
        try:
            FileUtil.createFolder(videoPath)
            # AT.cameraStartBatchRecord(videoPath, CAMERA_INDEX, CAMERA_RECORD_DURATION, timeout=CAMREA_API_TIMEOUT)
            self._videoRecordTask = VideoRecorderTask(videoPath)
            self._videoRecordTask.start()
        except Exception as exp:
            AT.LogInfo(f"startRecordVideo caught exp: {exp}")

    def stopRecordVideo(self):
        try:
            # AT.cameraStopRecord(CAMERA_INDEX)
            if self._videoRecordTask is not None:
                self._videoRecordTask.stopRecord()
                self._videoRecordTask = None
        except Exception as exp:
            AT.LogInfo(f"stopRecordVideo caught exp: {exp}")

    def startVipSocHeart(self, caseFolder):
        try:
            self._vipSocHeart = VipSocHeart(caseFolder)
            self._vipSocHeart.start()
        except Exception as exp:
            AT.LogInfo(f"startVipSocHeart caught exp: {exp}")

    def stopVipSocHeart(self):
        try:
            if self._vipSocHeart is not None:
                self._vipSocHeart.stopTask()
                self._vipSocHeart = None
        except Exception as exp:
            AT.LogInfo(f"stopVipSocHeart caught exp: {exp}")

    def setStressProperty(self):
        try:
            retcode, response = CommandExcutor.excute(SET_STRESS_AUTOMATION_PROPERTY_CMD.format(1), shell=True)
            if retcode != Constant.ExcuteCommandResult.success.value:
                return False

            retcode, response = CommandExcutor.excute(GET_STRESS_AUTOMATION_PROPERTY_CMD, shell=True)
            if retcode != Constant.ExcuteCommandResult.success.value:
                return False

            stressPropertyValue = response.splitlines()[0].strip()
            AT.LogInfo(f"stressPropertyValue: {stressPropertyValue}")
            return stressPropertyValue == "1"
        except Exception as exp:
            AT.LogInfo(f"setStressProperty caught exp: {exp}")
            return False

    def clearStressProperty(self):
        try:
            CommandExcutor.excute(SET_STRESS_AUTOMATION_PROPERTY_CMD.format(0), shell=True)
        except Exception as exp:
            AT.LogInfo(f"clearStressProperty caught exp: {exp}")

    def setup(self):
        ret = self.init(CASE_PATH, Constant.ScenarioType.stress.value, CASE_DURATION, wifiConnect=False, finishEvent=EventConstant.eventName.monkeyFinished.value)
        if not ret:
            AT.LogInfo("SystemPressureRunner, init failed...")
            sys.exit(0)

        # register exception event
        EventEmitter.getInstance().register(EventConstant.eventName.pressureExceptionEvent.value, self.onExceptionFinish, module=EventConstant.EventModule.performance.value)
        # set stress automation property to prevent notification
        ret = self.setStressProperty()
        if not ret:
            AT.LogInfo("set stress property failed...")
            sys.exit(0)

    def main(self):
        self.startRecordVideo(FileUtil.generateAbsPath(CASE_PATH, "video"))
        # start dump performance datas
        self.dumpDatas(Constant.ScenarioType.stress.value)
        # start vip soc heart
        self.startVipSocHeart(CASE_PATH)
        self.startSystemServiceChecker()
        self.startClusterFunctions()
        if START_MONKEY:
            self.startMonkeyTest(packageActivity=SINGLE_APP_MONKEY_PACKAGE_ACTIVITY)

        self.startExceptionChecker(EventConstant.EventModule.performance.value)
        self.waitFinish(durationSec=CASE_DURATION)

    def teardown(self):
        self.stopVipSocHeart()
        self.stopExceptionChecker()
        self.stopClusterFunctions()
        self.stopMonkeyTest()
        self.stopRecordVideo()
        self.stopSystemServiceChecker()
        self.onFinish()

        EventEmitter.getInstance().unregister(EventConstant.eventName.pressureExceptionEvent.value, module=EventConstant.EventModule.performance.value)
        # reset stress automation property
        self.clearStressProperty()


if __name__ == '__main__':
    testApp().run()
