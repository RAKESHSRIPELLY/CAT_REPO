import paramiko
import os
import subprocess
import time
import cv2 
import numpy as np 
from skimage import color, io, measure
from PIL import Image, ImageChops
from robot.libraries.BuiltIn import BuiltIn

def acquire_qnx_display_picture(terminals,screenshot_name, result_dir,display_num=1):
    """
    Acquires a screenshot from a QNX terminal and saves it to a specified directory.

    Parameters:
    - terminals (tuple): A tuple containing the SFTP and SSH connections to the QNX terminal.
    - screenshot_name (str): The name to be used for the screenshot file (excluding file extension).
    - result_dir (str): The directory where the screenshot will be saved.
    - display_num (int, optional): The display number to use for the screenshot (default is 1).

    Raises:
    - Exception: If there is an error executing the screenshot command or copying the file.

    Example:
    terminals = (sftp_connection, ssh_connection)
    acquire_qnx_display_picture(terminals, 'screenshot_1', '/path/to/save', display_num=2)
    """
    sftp, ssh = terminals
    try:  
        screenshot_command = f'screenshot -file=data/screenshot.png -display={display_num}'
        ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command(screenshot_command)
        print("Screenshot command executed successfully.")
        time.sleep(5)
        sftp.get(f'data/screenshot.png', f'{result_dir}//{screenshot_name}.png')
        time.sleep(5)
        # sftp.remove(f'data/screenshot.png')
        print("File copied successfully.")
    except Exception as e:
        print(f"Error executing screenshot command: {e}")
        BuiltIn.fail("Error executing screenshot command")
 
def qnx_screen_engage_touch_at(terminals,x,y,displaynum=2):
    """
    Simulates a touch event at the specified coordinates on a QNX terminal screen.

    Parameters:
    - terminals (tuple): A tuple containing the SFTP and SSH connections to the QNX terminal.
    - x (int): The x-coordinate where the touch event should be simulated.
    - y (int): The y-coordinate where the touch event should be simulated.
    - displaynum (int, optional): The display number to use for the touch event (default is 2).

    Raises:
    - Exception: If there is an error simulating the touch event.

    Example:
    terminals = (sftp_connection, ssh_connection)
    qnx_screen_engage_touch_at(terminals, 100, 200, displaynum=1)
    """
    sftp, ssh = terminals
    try:
        ssh.exec_command(f'qnx_touch -d {displaynum} -x {x} -y {y} && sleep 2')
    except Exception as e:
        print(f"not able to tap {e}")
        BuiltIn.fail(f"not able to tap {e}")
       
 
def initiate_remote_qnx_communication(host):
    """
    Initiates a remote communication session with a QNX terminal using SSH.

    Parameters:
    - host (str): The IP address or hostname of the QNX terminal.

    Returns:
    - tuple: A tuple containing the SFTP (Secure File Transfer Protocol) and SSH (Secure Shell) connections.

    Raises:
    - Exception: If there is an error establishing the SSH connection or executing the SSH command.

    Example:
    host_address = '192.168.1.1'
    sftp_connection, ssh_connection = initiate_remote_qnx_communication(host_address)
    # Use sftp_connection and ssh_connection for remote QNX communication
    """
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(hostname=host, username='root', password='')  
        ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@{}".format(host))
        print("SSH command executed successfully.")
 
        sftp = ssh.open_sftp()
        return sftp, ssh  
    except Exception as e:
        print(f"Error establishing connection or executing SSH command: {e}")
        BuiltIn.fail("Error establishing connection or executing SSH command")


def engage_touch_at(x, y):
    """
    Simulates a touch event on an Android device at the specified screen coordinates using ADB (Android Debug Bridge).

    Parameters:
    - x (int): The x-coordinate where the touch event should be simulated.
    - y (int): The y-coordinate where the touch event should be simulated.

    Raises:
    - subprocess.CalledProcessError: If there is an error executing the ADB command.
    - Exception: For unexpected errors during the touch simulation.

    Example:
    engage_touch_at(100, 200)
    # Simulates a touch event at X: 100, Y: 200 on the connected Android device.
    """
    try:
        command = f"adb shell input tap {x} {y}"
        subprocess.call(command, shell=True)
        print(f"Engage Touch at X: {x}, Y: {y}")
    except subprocess.CalledProcessError as e:
        print(f"Error executing adb command: {e}")
        BuiltIn.fail(f"Error executing adb command: {e}")
    except Exception as ex:
        print(f"An unexpected error occurred: {ex}")
        BuiltIn.fail(f"An unexpected error occurred: {ex}")


def conduct_swipe_sequence(x1, y1, x2, y2, speed=100):
    """
    Simulates a swipe gesture on an Android device from the starting coordinates (x1, y1) to the ending coordinates (x2, y2)
    using ADB (Android Debug Bridge).

    Parameters:
    - x1 (int): The starting x-coordinate of the swipe.
    - y1 (int): The starting y-coordinate of the swipe.
    - x2 (int): The ending x-coordinate of the swipe.
    - y2 (int): The ending y-coordinate of the swipe.
    - speed (int, optional): The speed of the swipe (default is 100).

    Raises:
    - subprocess.CalledProcessError: If there is an error executing the ADB command.
    - Exception: For unexpected errors during the swipe simulation.

    Example:
    conduct_swipe_sequence(100, 200, 300, 400, speed=150)
    # Simulates a swipe sequence from X1: 100, Y1: 200 to X2: 300, Y2: 400 with a speed of 150 on the connected Android device.
    """
    try:
        command = f"adb shell input swipe {x1} {y1} {x2} {y2} {speed}"
        subprocess.call(command, shell=True)
        print(f"Conduct Swipe Sequence at X1: {x1}, Y1: {y1} X2: {x2}, Y2: {y2}")
    except subprocess.CalledProcessError as e:
        print(f"Error executing adb command: {e}")
        BuiltIn.fail(f"Error executing adb command: {e}")
    except Exception as ex:
        print(f"An unexpected error occurred: {ex}")
        BuiltIn.fail(f"An unexpected error occurred: {e}")

def search_and_invoke_tap(word):
    """
    Searches for a specified word in the UI hierarchy of the connected Android device using ADB and
    simulates a tap at the center of the identified UI element.

    Parameters:
    - word (str): The word to search for in the UI hierarchy.

    Returns:
    - bool: True if the word is found, and a tap is successfully simulated; False otherwise.

    Raises:
    - subprocess.CalledProcessError: If there is an error executing the ADB command.
    - Exception: For unexpected errors during the process.

    Example:
    search_and_invoke_tap("settings")
    # Searches for the word "settings" in the UI hierarchy and simulates a tap at its center if found.
    """
    try:
        cmd = "adb exec-out uiautomator dump /dev/tty"
        output = subprocess.run(f"{cmd}", capture_output=True, text=True)
        output = output.stdout.lower()
        print("output is " + output)
        print("looking for word: '" + word.lower() + "'")
        index = output.find(word.lower())
        
        if index != -1:
            print("found word")
            indexBound = output.find("bounds=", index)
            indexBoundEnd = output.find('"', indexBound+8)
            bounds = output[indexBound+8:indexBoundEnd]
            print(bounds)

            leftx = int(bounds[1:bounds.find(',')])
            rightx = int(bounds[bounds.find('[', 1)+1 : bounds.find(',', bounds.find('[', 1)+1)])
            tapx = (leftx + rightx) / 2 
            lefty = int(bounds[bounds.find(',')+1:bounds.find(']')])
            righty = int(bounds[bounds.find(',', bounds.find(']')+2)+1 : -1])
            tapy = (lefty + righty) / 2 
            print(tapx, tapy)
            engage_touch_at(tapx, tapy)
            return True

        print(f"failed to find {word}")
        return False
    except subprocess.CalledProcessError as e:
        print(f"Error executing adb command: {e}")
        BuiltIn.fail(f"Error executing adb command: {e}")
        return False
    except Exception as ex:
        print(f"An unexpected error occurred: {ex}")
        BuiltIn.fail(f"An unexpected error occurred: {ex}")
        return False

def identify_and_scroll_to_phrase(word):
    """
    Identifies a specified word in the UI hierarchy of the connected Android device using ADB.
    If the word is found, it simulates a tap at the center of the identified UI element.
    If the word is not found after several attempts, it conducts a swipe gesture to scroll the screen.

    Parameters:
    - word (str): The word to search for in the UI hierarchy.

    Returns:
    - bool: True if the word is found and a tap is successfully simulated; False otherwise.

    Raises:
    - Exception: For unexpected errors during the process.

    Example:
    identify_and_scroll_to_phrase("settings")
    # Identifies the word "settings" in the UI hierarchy, simulates a tap if found, or conducts a swipe to scroll the screen.
    """
    try:
        found = False
        i = 0
        while not found and i < 15:
            cmd = "adb exec-out uiautomator dump /dev/tty"
            output = subprocess.run("{}".format(cmd), capture_output=True, text=True)
            output = output.stdout.lower()
            index = output.find(word.lower())
            if index != -1:
                indexBound = output.find("bounds=", index)
                indexBoundEnd = output.find('"', indexBound+8)
                bounds = output[indexBound+8:indexBoundEnd]
                leftx = int(bounds[1:bounds.find(',')])
                rightx = int(bounds[bounds.find('[', 1)+1 : bounds.find(',', bounds.find('[', 1)+1)])
                tapx = (leftx + rightx) / 2 
                lefty = int(bounds[bounds.find(',')+1:bounds.find(']')])
                righty = int(bounds[bounds.find(',', bounds.find(']')+2)+1 : -1])
                tapy = (lefty + righty) / 2
                engage_touch_at(tapx,tapy) 
                found = True
            if not found:
                conduct_swipe_sequence(1300, 500,400,500)
                time.sleep(3)
                i += 1
        return found
    except Exception as err:
        BuiltIn.fail(err)
        return err
    
def navigate_to_home():
    """
    Simulates a press of the HOME key on the connected Android device using ADB.

    Returns:
    - bool: True if the command is executed successfully; False otherwise.

    Raises:
    - Exception: For unexpected errors during the process.

    Example:
    navigate_to_home()
    # Simulates a press of the HOME key on the connected Android device.
    """
    try:
        found = False
        while not found:
            try:
                cmd = "adb shell input keyevent KEYCODE_HOME"
                output = subprocess.run(cmd, capture_output=True, text=True, check=True)
                output = output.stdout
                print(output)
                found = True
            except subprocess.CalledProcessError as e:
                print(f"Error executing command: {e}")
        return found   
    except Exception as err:
        BuiltIn.fail(err)
        return err 

# def check_adb_devices(device):
#     """
#     Checks if the specified Android device is connected using ADB.

#     Parameters:
#     - device (str): The identifier or name of the Android device to check.

#     Returns:
#     - bool: True if the device is connected; False otherwise.

#     Raises:
#     - subprocess.CalledProcessError: If there is an error executing the ADB command.
#     - Exception: For unexpected errors during the process.

#     Example:
#     check_adb_devices("your_device_identifier")
#     # Checks if the specified Android device is connected using ADB.
#     """
#     Found=False
#     try:
#         cmd = "adb devices"
#         output = subprocess.check_output(cmd, shell=True, text=True)
#         if device in output:
#             print("Your Device is Connected....")
#             Found = True
#             adb_call_retriever(device,BuiltIn().get_variable_value("${RESULTS_DIR}"))
#             return Found
#         else:
#             print("Device is not connected Properly Please Check Your Connection ...")
#             BuiltIn.fail(f"Error executing command: {e}")
#             return Found
#     except Exception as err:
#         print(f"Error executing command: {err}")
#         BuiltIn.fail(f"Error executing command: {err}")
#         return err
        
def authenticate_image_with_reference(image_path, image_name, ref_image_path, ref_image_name, threshold=0.8):
    """
    Compares an image with a reference image using template matching and checks if the reference image is present.

    Parameters:
    - image_path (str): The path to the folder containing the target image.
    - image_name (str): The name of the target image file.
    - ref_image_path (str): The path to the folder containing the reference image.
    - ref_image_name (str): The name of the reference image file.
    - threshold (float, optional): The threshold for considering a match (default is 0.8).

    Returns:
    - bool: True if the reference image is found in the target image above the specified threshold; False otherwise.

    Raises:
    - Exception: If there are issues with loading or processing the images.

    Example:
    authenticate_image_with_reference("images/target", "target_image.png", "images/reference", "reference_image.png", threshold=0.85)
    # Compares "target_image.png" with "reference_image.png" and returns True if a match is found above the threshold.
    """
    try:
        img_full_path = os.path.join(image_path, image_name)
        ref_full_path = os.path.join(ref_image_path, ref_image_name)

        img = cv2.imread(img_full_path, 0)
        template = cv2.imread(ref_full_path, 0)

        if img is None:
            raise Exception(f"result image located at {img_full_path} can't be found or at a wrong format")

        if template is None:
            raise Exception(f"reference image located at {ref_full_path} can't be found or at a wrong format")

        print("Searching '{}' with reference image '{}':".format(img_full_path, ref_full_path))
        result = cv2.matchTemplate(img, template, cv2.TM_SQDIFF_NORMED)
        if np.amax(result) > float(threshold):
            print(f"Reference image {ref_full_path} found in {img_full_path} with threshold {threshold}")
            template_result_path = os.path.join(image_path,'image_reference_match') 
            if not os.path.exists(template_result_path):
                os.makedirs(template_result_path)
            img_color = cv2.imread(img_full_path)
            result_full_path = os.path.join(template_result_path, image_name)
            w, h = template.shape[::-1]
            min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
            top_left = max_loc
            bottom_right = (top_left[0] + w, top_left[1] + h)
            cv2.rectangle(img_color, top_left, bottom_right, (0, 255, 0), 2)
            if cv2.imwrite(os.path.join(template_result_path, image_name), img_color):
                print("Saved result image to {}".format(template_result_path))
                return True
            else:
                print("Error saving result image to {}".format(template_result_path))
            return True
        else:
            print("Reference image '{}' NOT found in '{} with threshold '{}''".format(ref_full_path, img_full_path, threshold))
            BuiltIn.fail("Reference image was not found")
            return False
    except Exception as err:
        BuiltIn.fail("Reference image was not found")
        return err

        
def reference_image_not_found(image_path,image_name, reference_image_path,reference_image_name, threshold=0.8):
    """
    Checks if a reference image is not found in the specified image.

    Parameters:
    - image_path (str): The path of the image file.
    - image_name (str): The name of the image file.
    - reference_image_path (str): The path of the reference image file.
    - reference_image_name (str): The name of the reference image file.
    - threshold (float, optional): The minimum value of the correlation coefficient for a positive match (default is 0.8).

    Returns:
    - bool: True if the reference image is not found in the image; False otherwise.

    Example:
    reference_image_not_found("images/target", "target_image.png", "images/reference", "reference_image.png", threshold=0.85)
    # Returns True if the reference image is not found in the target image above the specified threshold.
    """
    image_path = os.path.join(image_path,image_name)
    reference_image_path = os.path.join(reference_image_path,reference_image_name)
    # Load the image and the template
    image = cv2.imread(image_path, 0)
    template = cv2.imread(reference_image_path, 0)
 
    # Compute the correlation coefficient between the image and the template
    result = cv2.matchTemplate(image, template, cv2.TM_CCOEFF_NORMED)
 
    # Find the coordinates of the maximum correlation value
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
 
    # If the correlation value exceeds the threshold, the image matches the template
    if max_val > threshold:
        BuiltIn.fail("Reference image was found")
        return False
    return True
    
def extract_coordinates_from_reference(image_path,image_name, reference_image_path,reference_image_name, threshold=0.8):
    """
    Extracts the coordinates of the maximum correlation value between an image and a reference template.

    Parameters:
    - image_path (str): The path of the image file.
    - image_name (str): The name of the image file.
    - reference_image_path (str): The path of the reference image file.
    - reference_image_name (str): The name of the reference image file.
    - threshold (float, optional): The minimum value of the correlation coefficient for a positive match (default is 0.8).

    Returns:
    - tuple: A tuple containing the (x, y) coordinates of the maximum correlation value.

    Example:
    extract_coordinates_from_reference("images/target", "target_image.png", "images/reference", "reference_image.png", threshold=0.85)
    # Returns the (x, y) coordinates of the maximum correlation value between the target image and the reference image.
    """
    try:
        image_path = os.path.join(image_path,image_name)
        reference_image_path = os.path.join(reference_image_path,reference_image_name)
        # Load the image and the template
        image = cv2.imread(image_path, 0)
        template = cv2.imread(reference_image_path, 0)
    
        # Compute the correlation coefficient between the image and the template
        result = cv2.matchTemplate(image, template, cv2.TM_CCOEFF_NORMED)
    
        # Find the coordinates of the maximum correlation value
        min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

        return max_loc
    except  Exception as err:
        BuiltIn.fail(err)
        return err

def launch_app(app_act_pack):
    """
    Launches an Android application using the specified activity and package.

    Parameters:
    - app_act_pack (str): The activity and package of the Android application in the format 'com.example.app/.MainActivity'.

    Returns:
    - bool: True if the application is successfully launched; False otherwise.

    Example:
    launch_app("com.example.myapp/.MainActivity")
    # Launches the Android application with the specified activity and package.
    """
    try:
        result = subprocess.run(f"adb shell am start -n {app_act_pack}")
        return True
    except Exception as err:
        print(err)
        BuiltIn.fail(err)
        return False
    
def retrive_cals_from_qnx(terminals):
    sftp, ssh = terminals
    try:
        ssh.exec_command(f'qnx_touch -d {displaynum} -x {x} -y {y} && sleep 2')
    except Exception as e:
        print(f"not able to tap {e}")
        BuiltIn.fail(f"not able to tap {e}")
        
# def adb_call_retriever(adb_device,path):
#     """
#     Use this instead of extract_gmlogger when needed
#     Extracts 'only' the calibrations from the connected Android device.
#     """
#     # check if device is connected
#     output = subprocess.run("adb -s {} root".format(adb_device), capture_output=True, text=True)
#     if ("unable to connect for root" in output.stdout):
#         return False
#     time.sleep(1)
#     # pull gmlogger from android
#     subprocess.call("adb -s {} pull /data/gmlogger/calibration_values_bootup_copy.txt {}".format(adb_device, path), shell=True)
#     return True


# def cal_check(calibration_name, calibration_value):
#     """
#     Verifies that the specified calibrations are set on the connected Android device.
#     Args:
#         calibration_name: Name of the calibration that should be verified.
#         calibration_value: Value that the calibration should be set to.
#     """
#     global is_calibrations_set_g 
#     flag = 0
#     is_calibrations_set = True
#     calibration_name = str(calibration_name)+":"
#     calibration_value = str(calibration_value)
#     override_set = 0
#     vip_set = 0
#     results_dir = BuiltIn().get_variable_value("${RESULTS_DIR}")
#     # open calibration file
#     try:
#         with open(os.path.join(results_dir, 'calibration_values_bootup_copy.txt')) as f:
#             # read txt file line by line to find the calibrations_dictionary key and verify the value
#             for line in f:
#                 if "Calibration Override files" in line:
#                     flag = 0
#                     continue
#                 elif "Calibration Values" in line:
#                     flag = 1
#                     continue  
#                 line = line.replace(" ", "")
#                 if calibration_name in line:
#                     push_type = "VIP" if flag else "override" # could also just set this variable in first if/elif
#                     if line[:-1].endswith("{}".format(calibration_value)) == False:
#                         BuiltIn().log_to_console("Calibration is {} in {}".format(line, push_type))
#                         BuiltIn().log_to_console("which is not correct, has to be {}".format(calibration_value))
#                         is_calibrations_set = False

#                         if push_type=="VIP":
#                             vip_set = 0
#                         else:
#                             override_set = 0
#                     else:
#                         if push_type=="override":
#                             override_set = 1
#                         else:
#                             vip_set = 1
#         f.close()
#     except:
#         BuiltIn().log_to_console("No calibration_values_bootup_copy file found...BIG ERROR")
#     if (is_calibrations_set==False):
#         if (vip_set==0 and override_set==1):
#             BuiltIn().log("Calibration is set correctly in override file but not VIP, so cal needs to be vip flashed to take effect",level="WARN")
#         elif (vip_set==1 and override_set==0):
#             BuiltIn().log("Calibration is set correctly in VIP file but not override, so cal needs to be overwritten in override file...doing it now")
#             make_cal(calibration_name, calibration_value)
#             restart_vcu()
#             BuiltIn().log("Pushed {}{} to override file, should be good".format(calibration_name, calibration_value), level="WARN")
#         elif (vip_set==0 and override_set==0):
#             BuiltIn().log("Calibration is NOT set correctly in override file and VIP",level="WARN")
#             make_cal(calibration_name, calibration_value)
#             restart_vcu()
#             BuiltIn().log("Pushed {}{} to override file HOWEVER cal may need to be VIP FLASHED to work properly".format(calibration_name, calibration_value), level="WARN")
#         else:
#             BuiltIn().log_to_console("ERROR in cal contradiction detected!")
#     else:
#         BuiltIn().comment("Calibration is set correctly!")
#     return is_calibrations_set

# def make_cal(calibration_name, calibration_value):
#     dir = BuiltIn().get_variable_value("${REFERENCES_DIR}")
#     search_word = "{}{}".format(calibration_name, calibration_value)
#     global is_calibrations_set_g 
#     is_calibrations_set_g = False
#     try:
#         flag=0
#         with open("{}cal.override".format(dir), 'r') as file:
#             data = file.readlines()
#             for i in data:    # for i in range(len(data)-1):
#                 if calibration_name in i:
#                     BuiltIn().log_to_console("inside cal.override...cal is set to {}".format(i))
#                     i = search_word
#                     flag = 1
#         file.close()
#         BuiltIn().log_to_console("cal.override found, editting it.....")
#         if flag == 1:
#             with open("{}cal.override".format(dir), 'w') as file:
#                 for j in range(len(data)):
#                     if calibration_name in data[j]:
#                         data[j] = search_word + "\n"
#                 for j in range(len(data)):
#                     file.writelines(data[j])
#                 BuiltIn().log_to_console("inside cal.override...rewritting cal")# to {}".format(data))
#             file.close()
#         if flag == 0:
#             with open("{}cal.override".format(dir), "a+") as f:
#                 f.write("\n" + search_word)
#                 BuiltIn().log_to_console("inside cal.override...appending cal with {}".format(search_word))
#             f.close()
#         with open("{}cal.override".format(dir), 'r') as file:
#             data = file.readlines()
#         file.close()
#         with open("{}cal.override".format(dir), 'w') as file:
#             for j in range(len(data)):
#                 if data[j] == "\n":
#                     continue
#                 elif j == len(data)-1 and "\n" == data[j][-1]:
#                     data[j] = data[j][:-1]
#                 file.writelines(data[j])
#         file.close()          
#     except FileNotFoundError:
#         BuiltIn().log_to_console("cal.override not found, making new one.....")
#         with open("{}cal.override".format(dir), "a+") as f:
#             f.write(search_word)
#         f.close()
#     return True

# def restart_vcu():
#     dir = BuiltIn().get_variable_value("${REFERENCES_DIR}")
#     check_file = os.path.exists(dir + "cal.override")
#     global is_calibrations_set_g
#     if (check_file == False) or (is_calibrations_set_g == True):
#         BuiltIn().log_to_console("Not rebooting because no override file exists or cals are correct")
#         return False
#     subprocess.run('adb -s {} push "{}cal.override" /data/vendor/calibrations'.format(adb_device, dir),capture_output=True, text=True)
#     time.sleep(3)
#     subprocess.run('adb -s {} shell sync'.format(adb_device),capture_output=True, text=True)
#     time.sleep(3)
#     subprocess.run('adb -s {} shell sync'.format(adb_device),capture_output=True, text=True)
#     time.sleep(3)
#     BuiltIn().log_to_console("Rebooting.....")
#     reboot_signal_dispatch(300)
#     is_calibrations_set_g = True
#     return True
