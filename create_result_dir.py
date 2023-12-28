import datetime
import os
from pathlib import Path

from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError


class cat_global_ctx:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    cat_dir = str(Path(os.path.abspath(os.path.dirname(__file__))).parents[0])
    result_dir_root = cat_dir + "\\results\\"

    def __init__(self):
        try:
            self.timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

            veh_program = BuiltIn().get_variable_value("${vehicle_program}")
            variant = BuiltIn().get_variable_value("${variant}")
            self.result_dir_root = self.result_dir_root + "{}_{}_{}_results".format(veh_program, variant, self.timestamp)

            if not os.path.exists(self.result_dir_root):
                os.makedirs(self.result_dir_root)

            # for every \ in result_dir_root, add another one right after it
            self.result_dir_root = self.result_dir_root.replace("\\", "\\\\")
            BuiltIn().set_global_variable("${RESULTS_DIR}", self.result_dir_root)
            BuiltIn().set_global_variable("${OUTPUT_DIR}",self.result_dir_root)
        except RobotNotRunningError:
            pass

def main():
    cat = cat_global_ctx()


if __name__ == "__main__":
    main()
