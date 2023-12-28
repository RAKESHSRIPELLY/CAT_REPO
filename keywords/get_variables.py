import os
import json
from pathlib import Path
import datetime

from robot.libraries.BuiltIn import BuiltIn


def get_variables(cur_dir, suite_name, vehicle_program):
    """
    Sets up and retrieves various variables needed for test execution.

    Args:
    - cur_dir (str): The current directory of the test.
    - suite_name (str): The name of the test suite.
    - vehicle_program (str): The name of the vehicle program.

    Returns:
    - dict: A dictionary containing the following variables:
      - "CURDIR": The current directory of the test.
      - "${RESULTS_DIR}": The root directory for storing test results.
      - "${SUITE_RESULTS_DIR}": The directory for storing results specific to the test suite.
      - "${REFERENCES_DIR}": The directory containing reference images.
      - "${CAT_DIR}": The parent directory of the current script.
    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    cat_dir = str(Path(os.path.abspath(os.path.dirname(__file__))).parents[0])
    result_dir_root = cat_dir + "\\results\\"
    if not os.path.exists(result_dir_root):
        os.mkdir(result_dir_root)
    timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

    veh_program = BuiltIn().get_variable_value("${vehicle_program}")
    # variant = BuiltIn().get_variable_value("${variant}")
    result_dir_root = result_dir_root + "{}_{}_results".format(veh_program, timestamp)

    if not os.path.exists(result_dir_root):
        os.makedirs(result_dir_root)
    result_dir_root = result_dir_root.replace("\\", "\\\\")
    BuiltIn().set_global_variable("${RESULTS_DIR}",result_dir_root)
    suite_results_dir = BuiltIn().get_variables()['${RESULTS_DIR}'] + "\\" + suite_name + "\\"

    suite_results_dir = suite_results_dir.replace("\\", "\\\\")
    BuiltIn().set_local_variable("${SUITE_RESULTS_DIR}", suite_results_dir)

    if not os.path.exists(suite_results_dir):
        os.makedirs(suite_results_dir)    

    display_size = BuiltIn().get_variables()['${display_size}']
    reference_dir = str(Path(os.path.abspath(os.path.dirname(__file__))).parents[
                            0]) + "\\references\\"+display_size+"\\"+vehicle_program+"\\"
    reference_dir = reference_dir.replace("\\", "\\\\")
    BuiltIn().set_local_variable("${REFERENCES_DIR}", reference_dir)

    cat_dir = str(Path(os.path.abspath(os.path.dirname(__file__))).parents[0])
    cat_dir = cat_dir.replace("\\", "\\\\")
    BuiltIn().set_local_variable("${CAT_DIR}", cat_dir)

    variables = {"CURDIR": cur_dir}
    return variables
