from robot.libraries.BuiltIn import BuiltIn

from GMVehicleSim import *

_gmVehicleSim = GMVehicleSim()

_shutdown = threading.Event()
_shutdown.clear()
_packet = None
heartbeat = None

swc_buttons = {'default': '00006020', 'pushToTalk': '00006220', 'volumeUp': '00046020', 'volumeDown': '00086020',
                    'selectPress': '00006120', 'voiceCommunication': '00006820', 'leftPress': '00406020', 
                    'rightPress': '00806020', 'hangUpPress': '00106020', 'upPress': '00106020', 'downPress': '00206020',
                    'previousPress': '00016020', 'nextPress': '00026020', 'mutePress': '00006420', 'clusterView': '00007020',
                    'anyStuck': '0000E020', 'wheelUp': '00006060', 'wheelDown': '000060A0'}


def initialize_vehicle_sim():
    """
    Initializes GM Vehicle Simulator. This should run BEFORE any other vehicle simulator interaction.
    """
    BuiltIn().log_to_console("Initializing GM Vehicle Simulator...")
    global heartbeat
    heartbeat = Thread(target=heartbeat_handler, daemon=True)
    heartbeat.start()

    global _gmVehicleSim
    _gmVehicleSim.on_receive(on_receive)


def on_receive(packet):
    if packet['Name']:
        #print("RX: CAN ID: " + packet['Id'] + " Name: " + packet['Name'] + " Value: " + packet['value'] + "\n")
        global _packet
        _packet = packet


def heartbeat_handler():
    global _shutdown
    global _gmVehicleSim

    while not _shutdown.is_set():
        if not _gmVehicleSim.is_connected():
            _gmVehicleSim.open()
        else:
            time.sleep(2)
    time.sleep(2)


def signal_dispatch(signal_name_key, signal_value):
    """
    Sends a signal update through GM Vehicle Simulator.
    Args:
        plain_english_signal_name: signal name that should be sent to GM Vehicle Simulator.
        signal_value: signal value that should be sent to GM Vehicle Simulator.

    Returns:
        True: Signal update was sent successfully
        False: Signal update was NOT sent successfully
    """
    global _gmVehicleSim
    
    # signal_name = signals.signals.get(signal_name_key, signal_name_key)

    # BuiltIn().log_to_console("Sending signal update... signal name: " + str(signal_name) + " | signal value: " + str(signal_value))

    payload = [{'Type': 'Signal', 'Name': str(signal_name_key), 'Value': str(signal_value), 'Periodic': 'true'}]

    time.sleep(1)
    # send
    if len(payload) > 0 and _gmVehicleSim.send(payload):
        BuiltIn().log_to_console('Payload: ' + str(payload))
        return True
    else:
        BuiltIn().fail("Unable to send signal update!")
        return False
    
def reboot_signal_dispatch(sleepTime=60):
    """
    Sends a VCU power cycle request to GM Vehicle Simulator.
    """
    payload  = [{'Type': 'VehicleSim', 'Name': 'mode', 'Value': 'reboot'}]
    time.sleep(1)
    if len(payload) > 0 and _gmVehicleSim.send(payload):
        BuiltIn().log_to_console('Payload: ' + str(payload))
        BuiltIn().log_to_console("Power cycling VCU....sleep timer is "+str(sleepTime)+"...")
        time.sleep(int(sleepTime))
        return True
    else:
        BuiltIn().fail("Unable to send reboot signal to VCU!")
        return False
    
def set_mode(mode):
    """
    Sends a mode update through GM Vehicle Simulator.
    Args:
        mode: Mode that should be sent to GM Vehicle Simulator. Can be
        off, acc, run, crank, propulsion, door_open_close

    Returns:
        True: Mode update was sent successfully
        False: Mode update was NOT sent successfully
    """
    global _gmVehicleSim

    payload = [{'Type': 'VehicleSim', 'Name': 'mode', 'Value': str(mode), 'Periodic': 'true'}]

    time.sleep(2)

    # send
    if len(payload) > 0 and _gmVehicleSim.send(payload):
        BuiltIn().log_to_console('Payload: ' + str(payload))
        return True
    else:
        BuiltIn().fail("Unable to send power mode update!")
        return False
    
def retrive_cals_from_qnx(terminals):
    sftp, ssh = terminals
    try:
        ssh.exec_command(f'qnx_touch -d {displaynum} -x {x} -y {y} && sleep 2')
    except Exception as e:
        print(f"not able to tap {e}")
        BuiltIn.fail(f"not able to tap {e}")
        
def adb_call_retriever(adb_device,path):
    """
    Use this instead of extract_gmlogger when needed
    Extracts 'only' the calibrations from the connected Android device.
    """
    # check if device is connected
    output = subprocess.run("adb -s {} root".format(adb_device), capture_output=True, text=True)
    if ("unable to connect for root" in output.stdout):
        return False
    time.sleep(1)
    # pull gmlogger from android
    subprocess.call("adb -s {} pull /data/gmlogger/calibration_values_bootup_copy.txt {}".format(adb_device, path), shell=True)
    return True

def cal_check(calibration_name, calibration_value,device_name):
    """
    Verifies that the specified calibrations are set on the connected Android device.
    Args:
        calibration_name: Name of the calibration that should be verified.
        calibration_value: Value that the calibration should be set to.
    """
    global is_calibrations_set_g 
    flag = 0
    is_calibrations_set = True
    calibration_name = str(calibration_name)+":"
    calibration_value = str(calibration_value)
    override_set = 0
    vip_set = 0
    results_dir = BuiltIn().get_variable_value("${RESULTS_DIR}")
    # open calibration file
    try:
        with open(os.path.join(results_dir, 'calibration_values_bootup_copy.txt')) as f:
            # read txt file line by line to find the calibrations_dictionary key and verify the value
            for line in f:
                if "Calibration Override files" in line:
                    flag = 0
                    continue
                elif "Calibration Values" in line:
                    flag = 1
                    continue  
                line = line.replace(" ", "")
                if calibration_name in line:
                    push_type = "VIP" if flag else "override" # could also just set this variable in first if/elif
                    if line[:-1].endswith("{}".format(calibration_value)) == False:
                        BuiltIn().log_to_console("Calibration is {} in {}".format(line, push_type))
                        BuiltIn().log_to_console("which is not correct, has to be {}".format(calibration_value))
                        is_calibrations_set = False

                        if push_type=="VIP":
                            vip_set = 0
                        else:
                            override_set = 0
                    else:
                        if push_type=="override":
                            override_set = 1
                        else:
                            vip_set = 1
        f.close()
    except:
        BuiltIn().log_to_console("No calibration_values_bootup_copy file found...BIG ERROR")
    if (is_calibrations_set==False):
        if (vip_set==0 and override_set==1):
            BuiltIn().log("Calibration is set correctly in override file but not VIP, so cal needs to be vip flashed to take effect",level="WARN")
        elif (vip_set==1 and override_set==0):
            BuiltIn().log("Calibration is set correctly in VIP file but not override, so cal needs to be overwritten in override file...doing it now")
            make_cal(calibration_name, calibration_value)
            restart_vcu(device_name)
            BuiltIn().log("Pushed {}{} to override file, should be good".format(calibration_name, calibration_value), level="WARN")
        elif (vip_set==0 and override_set==0):
            BuiltIn().log("Calibration is NOT set correctly in override file and VIP",level="WARN")
            make_cal(calibration_name, calibration_value)
            restart_vcu(device_name)
            BuiltIn().log("Pushed {}{} to override file HOWEVER cal may need to be VIP FLASHED to work properly".format(calibration_name, calibration_value), level="WARN")
        else:
            BuiltIn().log_to_console("ERROR in cal contradiction detected!")
    else:
        BuiltIn().comment("Calibration is set correctly!")
    return is_calibrations_set

def make_cal(calibration_name, calibration_value):
    dir = BuiltIn().get_variable_value("${REFERENCES_DIR}")
    search_word = "{}{}".format(calibration_name, calibration_value)
    global is_calibrations_set_g 
    is_calibrations_set_g = False
    try:
        flag=0
        with open("{}cal.override".format(dir), 'r') as file:
            data = file.readlines()
            for i in data:    # for i in range(len(data)-1):
                if calibration_name in i:
                    BuiltIn().log_to_console("inside cal.override...cal is set to {}".format(i))
                    i = search_word
                    flag = 1
        file.close()
        BuiltIn().log_to_console("cal.override found, editting it.....")
        if flag == 1:
            with open("{}cal.override".format(dir), 'w') as file:
                for j in range(len(data)):
                    if calibration_name in data[j]:
                        data[j] = search_word + "\n"
                for j in range(len(data)):
                    file.writelines(data[j])
                BuiltIn().log_to_console("inside cal.override...rewritting cal")# to {}".format(data))
            file.close()
        if flag == 0:
            with open("{}cal.override".format(dir), "a+") as f:
                f.write("\n" + search_word)
                BuiltIn().log_to_console("inside cal.override...appending cal with {}".format(search_word))
            f.close()
        with open("{}cal.override".format(dir), 'r') as file:
            data = file.readlines()
        file.close()
        with open("{}cal.override".format(dir), 'w') as file:
            for j in range(len(data)):
                if data[j] == "\n":
                    continue
                elif j == len(data)-1 and "\n" == data[j][-1]:
                    data[j] = data[j][:-1]
                file.writelines(data[j])
        file.close()          
    except FileNotFoundError:
        BuiltIn().log_to_console("cal.override not found, making new one.....")
        with open("{}cal.override".format(dir), "a+") as f:
            f.write(search_word)
        f.close()
    return True

def restart_vcu(device_name):
    dir = BuiltIn().get_variable_value("${REFERENCES_DIR}")
    check_file = os.path.exists(dir + "cal.override")
    global is_calibrations_set_g
    if (check_file == False) or (is_calibrations_set_g == True):
        BuiltIn().log_to_console("Not rebooting because no override file exists or cals are correct")
        return False
    subprocess.run('adb root && rm -rf data/vendor/calibrations',capture_output=True, text=True)
    time.sleep(3)
    subprocess.run('adb -s {} push "{}cal.override" /data/vendor/calibrations'.format(device_name, dir),capture_output=True, text=True)
    time.sleep(3)
    subprocess.run('adb -s {} shell sync'.format(device_name),capture_output=True, text=True)
    time.sleep(3)
    subprocess.run('adb -s {} shell sync'.format(device_name),capture_output=True, text=True)
    time.sleep(3)
    BuiltIn().log_to_console("Rebooting.....")
    time.sleep(10)
    reboot_signal_dispatch(100)
    is_calibrations_set_g = True
    return True

def check_adb_devices(device):
    """
    Checks if the specified Android device is connected using ADB.

    Parameters:
    - device (str): The identifier or name of the Android device to check.

    Returns:
    - bool: True if the device is connected; False otherwise.

    Raises:
    - subprocess.CalledProcessError: If there is an error executing the ADB command.
    - Exception: For unexpected errors during the process.

    Example:
    check_adb_devices("your_device_identifier")
    # Checks if the specified Android device is connected using ADB.
    """
    global device_name
    device_name = device
    Found=False
    try:
        cmd = "adb devices"
        output = subprocess.check_output(cmd, shell=True, text=True)
        if device in output:
            print("Your Device is Connected....")
            Found = True
            adb_call_retriever(device,BuiltIn().get_variable_value("${RESULTS_DIR}"))
            return Found
        else:
            print("Device is not connected Properly Please Check Your Connection ...")
            BuiltIn.fail(f"Error executing command: {e}")
            return Found
    except Exception as err:
        print(f"Error executing command: {err}")
        BuiltIn.fail(f"Error executing command: {err}")
        return err