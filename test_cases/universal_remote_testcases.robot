*** Settings ***
Resource    ../config/config.robot
Library    ../keywords/newkeywords.py
Library    ../vehicle_sim.py
Variables    ../keywords/get_variables.py    ${CURDIR}    ${SUITE_NAME}    ${vehicle_program}
*** Variables ***
${one_pedal_driving_screen_reference_dilouge}    one_pedal_driving_screen_reference_dilouge
${see_more_controls_reference}    see_more_controls_reference
${see_more_controls}    see_more_controls
${universal_remote_screen}    universal_remote_screen
${universal_remote_screen_reference}    universal_remote_screen_reference
${place_vechile_inpark_reference}    place_vechile_inpark_reference
${add_remote_screen_reference}    add_remote_screen_reference
${dmode_screen_reference}    dmode_screen_reference
${use_dmode_checkbox_reference}    use_dmode_checkbox_reference
${test_screen_reference}    test_screen_reference
${itworked_screen_reference}    itworked_screen_reference
${edit_remote_screen_reference}    edit_remote_screen_reference
${delete_screen_reference}    delete_screen_reference
${delete_remote_screen_reference}    delete_remote_screen_reference
${cannot_add_remote_reference}    cannot_add_remote_reference
*** Test Cases ***
Setup
    log_to_console    Connecting to QNX via SSH
    ${ssh}    initiate_remote_qnx_communication    ${host_ip}
    Set Suite Variable     ${ssh}
    # retrive_cals_from_qnx    ${ssh}
    comment    Initializing GM Vehicle Simulator
    initialize_vehicle_sim
    log_to_console    Connecting to ADB
    check_adb_devices    ${device_name}
    set_mode    Propulsion
    Cal Check    KeOCD_int_SPEED_MENU_PRESENT    0    ${device_name}

TC_Camera_Interaction_Pop-UP_0025
    # Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    VSADP_VehSpdAvgDrvnAuth    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Log To Console    Changing gear to drive mode
    # Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    2
    Signal Dispatch    SWIP_StrgWhlAngCalStsAuth    4
    Set Mode    Propulsion
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${universal_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${add_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${cannot_add_remote_reference}.png
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${cannot_add_remote_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
TC_Camera_Interaction_Pop-UP_0026
    # Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    VSADP_VehSpdAvgDrvnAuth    0
    Log To Console    Changing gear to drive mode
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    2
    # Signal Dispatch    SWIP_StrgWhlAngCalStsAuth    4
    Set Mode    Propulsion
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${universal_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${add_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${dmode_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${use_dmode_checkbox_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${test_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    1s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${itworked_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    30s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${edit_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${delete_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${delete_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${delete_remote_screen_reference}.png
    
TC_Camera_Interaction_Pop-UP_0029
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    2
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    launch_app    ${controls_app}
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    Signal Dispatch    VSADP_VehSpdAvgDrvnAuth    9
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${universal_remote_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${universal_remote_screen}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${universal_remote_screen}.png    ${REFERENCES_DIR}    ${place_vechile_inpark_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    VSADP_VehSpdAvgDrvnAuth    0


