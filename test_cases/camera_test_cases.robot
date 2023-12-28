*** Settings ***
Resource    ../config/config.robot
Library    ../keywords/newkeywords.py
Library    ../vehicle_sim.py
Variables    ../keywords/get_variables.py    ${CURDIR}    ${SUITE_NAME}    ${vehicle_program}
*** Variables ***
${one_pedal_driving_screen_reference_dilouge}    one_pedal_driving_screen_reference_dilouge
${headlights_off_reference}    headlights_off_reference
${cancel_icon_reference}    cancel_icon_reference
${cancel_icon}    cancel_icon
${one_pedal_screenshot}    one_pedal_screenshot
${set_to_perecentage_screen_reference}    set_to_perecentage_screen_reference
${battery_level_screen_reference}    battery_level_screen_reference
${range_reverse_screen_reference}    range_reverse_screen_reference
${auto_park_assist_screen_reference}    auto_park_assist_screen_reference
${main_cargo_light_screen_reference}    main_cargo_light_screen_reference
${cargo_lights_screen_reference}    cargo_lights_screen_reference
${task_lights_screen_on_reference}    task_lights_screen_on_reference
${cancel_icon_reference}    cancel_icon_reference
${lights_screen_reference}    lights_screen_reference
${traction_control_off_screen_reference}    traction_control_off_screen_reference
${traction_control_screen_reference}    traction_control_screen_reference
${one_pedal_screen_reference}    one_pedal_screen_reference
${drive_and_park_screen_reference}    drive_and_park_screen_reference
${one_drive_screen_reference}    one_drive_screen_reference
${one_drive_screen}    one_drive_screen
${see_more_controls}    see_more_controls
${see_more_controls_reference}    see_more_controls_reference
${door_and_window_screen_reference}    door_and_window_screen_reference
${child_safety_lock_error_reference}    child_safety_lock_error_reference
${auto_park_assist}    auto_park_assist
${auto_park_assist_reference}    auto_park_assist_reference
${see_more_controls_reference}    see_more_controls_reference
${powerbase_vehicle_mustbe_park_reference}    powerbase_vehicle_mustbe_park_reference
${powerbase_vehicle_mustbe_park}    powerbase_vehicle_mustbe_park
${powerbase_controls_unavailable}    powerbase_controls_unavailable
${powerbase_controls_unavailable_reference}    powerbase_controls_unavailable_reference
${set_reverese_range_popup_5_reference}    set_reverese_range_popup_5_reference
${set_reverese_range_popup_5}    set_reverese_range_popup_5
${set_reverese_range_popup_0}    set_reverese_range_popup_0
${set_reverese_range_popup_0_reference}    set_reverese_range_popup_0_reference    
${set_reverese_range_popup_reference}     set_reverese_range_popup_reference
${set_reverese_range_popup}    set_reverese_range_popup
${turn_on_powerbase_popup_referenece}    turn_on_powerbase_popup_referenece
${turn_on_powerbase_popup}    turn_on_powerbase_popup
${auto_park_assist_unavailabe_reference}    auto_park_assist_unavailabe_reference
${auto_park_assist_unavailabe}    auto_park_assist_unavailabe
${cargo_lights_unavailable}    cargo_lights_unavailable
${cargo_lights_unavailable_reference}    cargo_lights_unavailable_reference
${task_lights_are_unavailable_reference}    task_lights_are_unavailable_reference
${task_lights_are_unavailable}    task_lights_are_unavailable
${auto_high_beams_unavailable}    auto_high_beams_unavailable
${auto_high_beams_unavailable_reference}    auto_high_beams_unavailable_reference
${foglight_unavaliable_snackbar_reference}    foglight_unavaliable_snackbar_reference
${foglight_unavaliable_snackbar}    foglight_unavaliable_snackbar
${capture_lights_page}    capture_lights_page    
${capture_lights_page_reference}    capture_lights_page_reference
${Traction_control_Icon}        Traction_control_Icon
${Selection_unavailable_Pop_UP}     Selection_unavailable_Pop_UP
${Selection_unavailable_Pop_UP_reference}    Selection_unavailable_Pop_UP_reference
${transition_control_diloug_bar}    transition_control_diloug_bar
${transition_control_diloug_bar_reference}    transition_control_diloug_bar_reference
${one_pedal_driving_screen_reference}    one_pedal_driving_screen_reference
${one_pedal_driving_screen}    one_pedal_driving_screen
${doors_and_windows_reference}    doors_and_windows_reference
${child_saftey_bar}    child_saftey_bar
${doors_and_windows}    doors_and_windows
${powerbase_dilouge_reference}    powerbase_dilouge_reference
${powerbase_range_reverse}    powerbase_range_reverse
${powerbase_range_reverse_reference}    powerbase_range_reverse_reference
${outlet_disabled_reference}    outlet_disabled_reference
${reset_outlets_reference}    reset_outlets_reference
${powerbase_try_dialog_reference}    powerbase_try_dialog_reference
${powerbase_screenshot}    powerbase_screenshot
${powerbase_screenshot_reference}    powerbase_screenshot_reference
${powerbase_dilouge}    powerbase_dilouge
${Snackbar_dilouge}    Snackbar_dilouge  
${snake_bar_dilouge_reference}    snake_bar_dilouge_reference
${backup_gudieline_reference}    backup_gudieline_reference  
${headlamp_popup_reference}    headlamp_popup_reference
${reverse_gear_reference}    reverse_gear_reference
${dioluge_bar_reference}    dioluge_bar_reference    
${door_close_reference}    door_close_reference
${door_open_reference}    door_open_reference
${reset_outlets}    reset_outlets
${outlet_disabled}    outlet_disabled
${powerbase_try_dialog}    powerbase_try_dialog
${reverse_gear_reference}    reverse_gear_reference    
${forward_gear}     forward_gear
${headlamp_popup}    headlamp_popup
${headlamp_popup1}    headlamp_popup1
${reverse_gear}    reverse_gear
${cluster_view}    gauge
${door_open}    door_open
${door_close}    door_close
${audio_dynamic_FM}    audio_dynamic_FM_new
${backup_guidline}     backup_gudieline
${dioluge_bar}    dioluge_bar

*** Test Cases ***
Setup
    log_to_console    Connecting to QNX via SSH
    ${ssh}    initiate_remote_qnx_communication    ${host_ip}
    Set Suite Variable     ${ssh}
    comment    Initializing GM Vehicle Simulator
    initialize_vehicle_sim
    log_to_console    Connecting to ADB
    check_adb_devices    ${device_name}
    set_mode    Propulsion

TC_Camera_Interaction_Pop-UP_0002
    Log To Console    Opening the door
    Signal Dispatch    DrvDrAjrStat    1
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_open}    ${SUITE_RESULTS_DIR}    1
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${door_open}.png    ${REFERENCES_DIR}    ${door_open_reference}.png
    Log To Console    Closing the door
    Signal Dispatch    DrvDrAjrStat    0
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_close}    ${SUITE_RESULTS_DIR}    1
    Sleep    2s
    Reference Image Not Found   ${SUITE_RESULTS_DIR}    ${door_close}.png    ${REFERENCES_DIR}    ${door_open_reference}.png
    Log To Console    Change the mode to propulsion
    set_mode    Propulsion
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    acquire_qnx_display_picture    ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Signal Dispatch    HdLmpSmrtCtlPrmtReqd    1 
    Sleep    2s
    acquire_qnx_display_picture    ${ssh}    ${headlamp_popup}   ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${headlamp_popup_reference}.png
    Signal Dispatch    HdLmpSmrtCtlPrmtReqd    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    10s

TC_Camera_Interaction_Pop-UP_0001
    Log To Console    Opening the door
    Signal Dispatch    DrvDrAjrStat    1
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_open}    ${SUITE_RESULTS_DIR}    1
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${door_open}.png    ${REFERENCES_DIR}    ${door_open_reference}.png    ${validation_confidence}
    Log To Console    Closing the door
    Signal Dispatch    DrvDrAjrStat    0
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_close}    ${SUITE_RESULTS_DIR}    2
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${door_close}.png    ${REFERENCES_DIR}    ${door_open_reference}.png 
    Signal Dispatch    HdLmpSmrtCtlPrmtReqd    1
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${headlamp_popup}    ${SUITE_RESULTS_DIR}    2
    set_mode    Propulsion
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    acquire_qnx_display_picture    ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${headlamp_popup_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    HdLmpSmrtCtlPrmtReqd    0
    Sleep    10s

TC_Camera_Regulation_0002
    Log To Console    Change the gear to reverse
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    30s
    acquire_qnx_display_picture    ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Log To Console    Changing the gear mode to forward
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${forward_gear}    ${SUITE_RESULTS_DIR}    2
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${forward_gear}.png    ${REFERENCES_DIR}    ${reverse_gear_reference}.png    1.0
    Sleep    10s

# TC_Camera_Regulation_0003
#     Log To Console    Change the mode to run
#     Set Mode    run
#     Log To Console    Changing the gear to reverse
#     Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3


TC_Camera_Regulation_0007
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    2
    Log To Console    Change the gear to reverse 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${reverse_gear}.png    ${SUITE_RESULTS_DIR}    2
    Log To Console    Activating backup guidelines
    Signal Dispatch    SWIP_StrgWhlAngCalStsAuth    2
    Sleep    5s
    acquire_qnx_display_picture    ${ssh}    ${backup_guidline}.png    ${SUITE_RESULTS_DIR}    2
    # ${SUITE_RESULTS_DIR}    ${backup_guidline}.png    ${REFERENCES_DIR}    ${backup_gudieline_reference}    ${validation_confidence}    True    ${SUITE_RESULTS_DIR}    ${backup_gudieline_reference}.png
    Signal Dispatch    SWIP_StrgWhlAngCalStsAuth    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    10s

TC_Camera_Interaction_Pop-UP_0008
    Log To Console    Opening the door
    Signal Dispatch    DrvDrAjrStat    1
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_open}    ${SUITE_RESULTS_DIR}    1
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${door_open}.png    ${REFERENCES_DIR}    ${door_open_reference}.png
    Log To Console    Closing the door
    Signal Dispatch    DrvDrAjrStat    0
    Sleep    3s
    acquire_qnx_display_picture    ${ssh}    ${door_close}    ${SUITE_RESULTS_DIR}    2
    ${result}    Reference Image Not Found   ${SUITE_RESULTS_DIR}    ${door_close}.png    ${REFERENCES_DIR}    ${door_open_reference}.png
    Signal Dispatch    PPMShwVehOffSwMnReqd    1
    Signal Dispatch    PPMVehOffPrssBtnAgnSmrtPrmtReqd    1
    Sleep    2s
    set_mode    Propulsion
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Log To Console    Verification og Vehicle Off Icon and also a SnackBar
    Signal Dispatch    PPMShwVehOffSwMnReqd    0
    Signal Dispatch    PPMVehOffPrssBtnAgnSmrtPrmtReqd    0
    Sleep    5s
    Signal Dispatch    PPMShwVehOffSwMnReqd    1
    Sleep    2s
    Signal Dispatch    PPMVehOffPrssBtnAgnSmrtPrmtReqd    1
    Sleep    1s
    Acquire Qnx Display Picture    ${ssh}    ${dioluge_bar}    ${SUITE_RESULTS_DIR}    2
    Sleep    2S
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${dioluge_bar}.png    ${REFERENCES_DIR}    ${dioluge_bar_reference}.png
    Sleep    2s
    Signal Dispatch    PPMShwVehOffSwMnReqd    0
    Signal Dispatch    PPMVehOffPrssBtnAgnSmrtPrmtReqd    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    10s

TC_Camera_Interaction_Pop-UP_0009
    Log To Console    Opening the door
    Signal Dispatch    DrvDrAjrStat    1
    Log To Console    Closing the door
    Signal Dispatch    DrvDrAjrStat    0
    Signal Dispatch    PPMVehOnExtModeActv    1
    Sleep    1s
    Signal Dispatch    PPMShwVehOffSwMnReqd    0
    Sleep    1s
    Signal Dispatch    PPMExtModeActvEnsBatChrgLvlIO    1
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    2s
    set_mode    Propulsion
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}     2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Signal Dispatch    PPMVehOnExtModeActv    0
    Signal Dispatch    PPMShwVehOffSwMnReqd    1
    Signal Dispatch    PPMExtModeActvEnsBatChrgLvlIO    0
    Sleep    2s
    Signal Dispatch    PPMVehOnExtModeActv    1
    Signal Dispatch    PPMShwVehOffSwMnReqd    0
    Signal Dispatch    PPMExtModeActvEnsBatChrgLvlIO    1
    Sleep    2s
    Acquire Qnx Display Picture    ${ssh}    ${Snackbar_dilouge}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${Snackbar_dilouge}.png    ${REFERENCES_DIR}    ${snake_bar_dilouge_reference}.png
    Signal Dispatch    PPMVehOnExtModeActv    0
    Signal Dispatch    PPMShwVehOffSwMnReqd    0
    Signal Dispatch    PPMExtModeActvEnsBatChrgLvlIO    0
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    10s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0011
    Log To Console       sending VMMP_VehMtnMvmtStatAuth to park
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Sleep    2s
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    launch_app    ${controls_app}
    Sleep    3s  
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}     2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Signal Dispatch    DrSeltdOtltOfPwMdVirCtlNAlwdSts    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_dilouge}    ${SUITE_RESULTS_DIR}    2
    Sleep    1s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_dilouge}.png    ${REFERENCES_DIR}    ${powerbase_dilouge_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${powerbase_dilouge_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    3s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    
TC_Camera_Interaction_Pop-UP_0012
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Log To Console       sending VMMP_VehMtnMvmtStatAuth to park
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    5s
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    5s
    launch_app    ${controls_app}
    # identify_and_scroll_to_phrase    PowerBase
    Signal Dispatch    OtltsOffPwrMdSysSts    0   
    Sleep    4s
    Acquire Qnx Display Picture    ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    # qnx_screen_engage_touch_at    1300    230    2
    Signal Dispatch    DrSeltdOtltOfPwMdVirCtlNAlwdSts    6
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_try_dialog}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    # Acquire Qnx Display Picture   ${ssh}    ${powerbase_dilouge}    ${SUITE_RESULTS_DIR}    2
    # Sleep    3s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_try_dialog}.png    ${REFERENCES_DIR}    ${powerbase_try_dialog_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${powerbase_try_dialog_reference}.png
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0013
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Log To Console       sending VMMP_VehMtnMvmtStatAuth to park
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    5s
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    5s
    launch_app    ${controls_app}
    Signal Dispatch    OtltsOffPwrMdSysSts    0   
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    Sleep    5s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    5s
    Signal Dispatch    DrSeltdOtltOfPwMdVirCtlNAlwdSts    2
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${reset_outlets}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${reset_outlets}.png    ${REFERENCES_DIR}    ${reset_outlets_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${reset_outlets_reference}.png
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0014
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Log To Console       sending VMMP_VehMtnMvmtStatAuth to park
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    5s
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    5s
    launch_app    ${controls_app}
    Sleep    5s
    Signal Dispatch    OtltsOffPwrMdSysSts    0   
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    Sleep    5s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    5s
    Signal Dispatch    DrSeltdOtltOfPwMdVirCtlNAlwdSts    4
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${outlet_disabled}    ${SUITE_RESULTS_DIR}    2
    Sleep    4s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${outlet_disabled}.png    ${REFERENCES_DIR}    ${outlet_disabled_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${outlet_disabled_reference}.png
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


TC_Camera_Interaction_Pop-UP_0015
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Log To Console       sending VMMP_VehMtnMvmtStatAuth to park
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    2s
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    OtltsOffPwrMdSysSts    0   
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_screenshot}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    Sleep    5s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${powerbase_screenshot}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    2s
    Signal Dispatch    DrSeltdOtltOfPwMdVirCtlNAlwdSts    5
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_range_reverse}    ${SUITE_RESULTS_DIR}    2
    Sleep    4s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_range_reverse}.png    ${REFERENCES_DIR}    ${powerbase_range_reverse_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${powerbase_range_reverse_reference}.png     
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


TC_Camera_Interaction_Pop-UP_0016
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    2s
    launch_app    ${controls_app}
    Signal Dispatch    VCCSLS_CtlAval    1
    Sleep    2s
    Signal Dispatch    VCCSLS_MsmtchIndOn    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${child_saftey_bar}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${child_saftey_bar}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${child_saftey_bar}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${child_saftey_bar}.png    ${REFERENCES_DIR}    ${door_and_window_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${child_saftey_bar}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${child_saftey_bar}.png    ${REFERENCES_DIR}    ${child_safety_lock_error_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${doors_and_windows}    ${SUITE_RESULTS_DIR}    2
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${doors_and_windows_reference}.png    
    Signal Dispatch    VCCSLS_CtlAval    0
    Signal Dispatch    VCCSLS_MsmtchIndOn    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


TC_Camera_Interaction_Pop-UP_0020
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    Signal Dispatch    VirtOnePedDrvCtlAval    1
    Signal Dispatch    OnePedDrvCstSetAvlFlg3    0
    Signal Dispatch    OnePedDrvCstSetAvlFlg4    1
    Signal Dispatch    VirtOnePedDrvUserCtlAllwd    1
    Signal Dispatch    OnePedDrvCstSetAllwdFlg2    0
    Signal Dispatch    OnePedDrvCstCurrSetVal    2
    navigate_to_home
    Sleep    2s
    Log    Clicking on See More Controls Button
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Sleep    3s
    # qnx_screen_engage_touch_at    480    820    2
    Log    Clicking on Drive & park screen
    # qnx_screen_engage_touch_at    330    305    2
    Acquire Qnx Display Picture   ${ssh}    ${one_drive_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    5s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${one_drive_screen}.png    ${REFERENCES_DIR}    ${drive_and_park_screen_reference}.png
    Sleep    5s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s 
    Log    Selecting On Option in One Pedal driving screen
    # Acquire Qnx Display Picture   ${ssh}    ${one_pedal_screenshot}   ${SUITE_RESULTS_DIR}    2
    # Sleep    3s
    # qnx_screen_engage_touch_at    1122    400    2
    Acquire Qnx Display Picture   ${ssh}    ${one_pedal_driving_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${one_pedal_driving_screen}.png    ${REFERENCES_DIR}    ${one_pedal_screen_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${one_pedal_driving_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    1s
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${one_pedal_driving_screen}.png    ${REFERENCES_DIR}    ${one_pedal_driving_screen_reference_dilouge}.png
    Log    Setting the Gear in Reverse Mode
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Acquire Qnx Display Picture  ${ssh}     ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${one_pedal_driving_screen_reference_dilouge}.png     
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0017
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    3s
    # qnx_screen_engage_touch_at    500    830    2
    # qnx_screen_engage_touch_at    480    820    2
    Log    Clicking on Drive & park screen
    # qnx_screen_engage_touch_at    330    305    2
    # qnx_screen_engage_touch_at    700    270    2
    Acquire Qnx Display Picture   ${ssh}    ${one_drive_screen}     ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${one_drive_screen}.png    ${REFERENCES_DIR}    ${drive_and_park_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Signal Dispatch    TrcStbScrConfig    3
    Signal Dispatch    TCSCustAv    0
    Signal Dispatch    VehStbEnhcmntCurStat    0
    Signal Dispatch    TCSCurStat    0
    Signal Dispatch    VehStbCompMdCurStat    0
    Sleep    2S
    Acquire Qnx Display Picture   ${ssh}    ${transition_control_diloug_bar}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${transition_control_diloug_bar}.png    ${REFERENCES_DIR}    ${traction_control_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s 
    Acquire Qnx Display Picture  ${ssh}     ${transition_control_diloug_bar}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${transition_control_diloug_bar}.png    ${REFERENCES_DIR}    ${transition_control_diloug_bar_reference}.png
    Log    Setting the Gear in Reverse Mode
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}   ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found   ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${transition_control_diloug_bar_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s     
    Signal Dispatch    TrcStbScrConfig    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    
TC_Camera_Interaction_Pop-UP_0019
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    # qnx_screen_engage_touch_at    500    830    2
    # qnx_screen_engage_touch_at    480    820    2
    Log    Clicking on Drive & park screen
    # qnx_screen_engage_touch_at    330    305    2
    # qnx_screen_engage_touch_at    330    280    2
    Acquire Qnx Display Picture   ${ssh}    ${one_drive_screen}    ${SUITE_RESULTS_DIR}    2
    Sleep    5s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${one_drive_screen}.png    ${REFERENCES_DIR}    ${drive_and_park_screen_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Signal Dispatch    TrcStbScrConfig    1
    Signal Dispatch    TCSCustAv    0
    Signal Dispatch    VehStbEnhcmntCurStat    0
    Signal Dispatch    TCSCurStat    1
    Log    verifying Traction control Icon
    Log    Tapping on OFF button in in traction control option.
    Acquire Qnx Display Picture   ${ssh}    ${Selection_unavailable_Pop_UP}     ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${Selection_unavailable_Pop_UP}.png    ${REFERENCES_DIR}    ${traction_control_off_screen_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2  
    Log    Verifying Selection unavailable Pop-UP is Displayed
    Acquire Qnx Display Picture   ${ssh}    ${Selection_unavailable_Pop_UP}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${Selection_unavailable_Pop_UP}.png    ${REFERENCES_DIR}    ${Selection_unavailable_Pop_UP_reference}.png 
    Log    Setting the Gear in Reverse Mode
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${Selection_unavailable_Pop_UP_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    TrcStbScrConfig    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0018
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Signal Dispatch    FTPP_VirtCtlHdPrkLmpsAvalAuth    1
    Signal Dispatch    FTPP_HdPrkLmpsCurrSeltnValAuth    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${lights_screen_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    # qnx_screen_engage_touch_at    330    305    2
    # qnx_screen_engage_touch_at    1200    367    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${headlights_off_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${capture_lights_page_reference}.png
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    Sleep    2s
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Log    Setting the Gear in Reverse Mode
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${capture_lights_page_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    FTPP_HdPrkLmpsCurrSeltnValAuth    0
    Signal Dispatch    FTPP_VirtCtlHdPrkLmpsAvalAuth    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0021
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Signal Dispatch  VCFLFS_CtlAval      1
    Signal Dispatch  VCFLFS_UsrCtlAllwd  1
    Signal Dispatch  VCFLFS_CurrSeltnVal     1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${lights_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${traction_control_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${foglight_unavaliable_snackbar}    ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${foglight_unavaliable_snackbar}.png    ${REFERENCES_DIR}    ${foglight_unavaliable_snackbar_reference}.png
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}   ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${foglight_unavaliable_snackbar_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch  VCFLFS_CtlAval      0
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2
    
TC_Camera_Interaction_Pop-UP_0022
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}     ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${lights_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Signal Dispatch  VCAHBS_CtlAval  1
    Signal Dispatch  VCAHBS_UsrCtlAllwd  1
    Signal Dispatch  VCAHBS_CurrSeltnVal     2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${traction_control_off_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${auto_high_beams_unavailable}    ${SUITE_RESULTS_DIR}    2
    Sleep    2s
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${auto_high_beams_unavailable}.png    ${REFERENCES_DIR}    ${auto_high_beams_unavailable_reference}.png
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${auto_high_beams_unavailable_reference}.png
    Signal Dispatch  VCAHBS_CtlAval      0
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    5s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0023
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Sleep    1s
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch  VCTLS_CtlAval  1
    Signal Dispatch   VCTLS_UsrCtlAllwd  1
    Signal Dispatch  VCTLS_CurrSeltnVal     1
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${lights_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    Sleep    3s
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${task_lights_screen_on_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${task_lights_are_unavailable}    ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${task_lights_are_unavailable}.png    ${REFERENCES_DIR}    ${task_lights_are_unavailable_reference}.png
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${task_lights_are_unavailable_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s
    Signal Dispatch  VCTLS_CtlAval      0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0024
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    launch_app    ${controls_app}
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${see_more_controls}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${see_more_controls}.png    ${REFERENCES_DIR}    ${see_more_controls_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${lights_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Signal Dispatch  VCTLS_CtlAval      0
    Signal Dispatch  VCCLS_CrgBedLmpAval  1
    Signal Dispatch   VCCLS_CrgLmpAval  1
    Signal Dispatch  VCCLS_CrgLmpHtchAval     1
    Signal Dispatch    VCCLS_CrgMirLmpAval    1
    Signal Dispatch    VCCLS_AllCrgLmpUsrCtlAllwd    1
    Signal Dispatch    VCCLS_CrgLmpCurrSeltnVal    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}     ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${cargo_lights_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${capture_lights_page}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${capture_lights_page}.png    ${REFERENCES_DIR}    ${main_cargo_light_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${cargo_lights_unavailable}   ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${cargo_lights_unavailable}.png    ${REFERENCES_DIR}    ${cargo_lights_unavailable_reference}.png
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${cargo_lights_unavailable_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch  VCCLS_CrgBedLmpAval  0
    Signal Dispatch   VCCLS_CrgLmpAval  0
    Signal Dispatch  VCCLS_CrgLmpHtchAval     0
    Signal Dispatch    VCCLS_AllCrgLmpUsrCtlAllwd    0
    Signal Dispatch    VCCLS_CrgLmpCurrSeltnVal    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0030

    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    SuprRmtPrkActvnPndgIndOn    1
    Acquire Qnx Display Picture   ${ssh}    ${auto_park_assist_unavailabe}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${auto_park_assist_unavailabe}.png    ${REFERENCES_DIR}    ${auto_park_assist_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${auto_park_assist_unavailabe}    ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference    ${SUITE_RESULTS_DIR}    ${auto_park_assist_unavailabe}.png   ${REFERENCES_DIR}    ${auto_park_assist_unavailabe_reference}.png
    Sleep    3s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${auto_park_assist_unavailabe_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s
    Signal Dispatch    SuprRmtPrkActvnPndgIndOn    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0032
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    2
    Log To Console    sending DrvrSeltdOtltOffPwrMdVirCtlAvl to available
    Sleep    2s
    launch_app    ${controls_app}
    Sleep    2s 
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${turn_on_powerbase_popup_referenece}.png
    Sleep    2s
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    ${result}    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${turn_on_powerbase_popup_referenece}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s    
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-powerbase_dilouge
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    30s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${range_reverse_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture  ${ssh}     ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${battery_level_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${set_to_perecentage_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${set_reverese_range_popup}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${set_reverese_range_popup}.png    ${REFERENCES_DIR}    ${set_to_perecentage_screen_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${set_to_perecentage_screen_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0 
    Sleep    2s   
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0033
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}   ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    30s
    Acquire Qnx Display Picture    ${ssh}   ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${range_reverse_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Sleep    1s
    qnx_screen_engage_touch_at    ${ssh}    383    800    2
    Acquire Qnx Display Picture   ${ssh}    ${set_reverese_range_popup_0}   ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${set_reverese_range_popup_0}.png    ${REFERENCES_DIR}    ${set_reverese_range_popup_0_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}     ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${set_reverese_range_popup_0_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0    
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


TC_Camera_Interaction_Pop-UP_0035
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    launch_app    ${controls_app}
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    30s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${range_reverse_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    qnx_screen_engage_touch_at    ${ssh}    450    800    2
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${set_reverese_range_popup_5}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${set_reverese_range_popup_5}.png    ${REFERENCES_DIR}    ${set_reverese_range_popup_5_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${set_reverese_range_popup_5_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0   
    Sleep    2s 
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


 TC_Camera_Interaction_Pop-UP_0036
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    Sleep    1s
    Signal Dispatch   VMMP_VehMtnMvmtStatAuth    1
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_vehicle_mustbe_park}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_vehicle_mustbe_park}.png    ${REFERENCES_DIR}    ${powerbase_vehicle_mustbe_park_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}     ${SUITE_RESULTS_DIR}     2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${powerbase_vehicle_mustbe_park_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0  
    Sleep    2s  
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    3s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2


TC_Camera_Interaction_Pop-UP_0037
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    OtltsOffPwrMdSysSts    0
    launch_app    ${controls_app}
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    1
    Sleep    1s
    Signal Dispatch    DrvrSeltdOtltOffPwMdVirCtlAllwd    1
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${powerbase_screenshot_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Signal Dispatch    DrSeltdOtltOffPwMdVirCtlSeltnVl    1
    Sleep    1s
    Signal Dispatch    DrSeltdOtltOffPwMdVirCtlSeltnVl    2
    # qnx_screen_engage_touch_at    480    850    2
    # Sleep    1s
    Acquire Qnx Display Picture   ${ssh}    ${powerbase_controls_unavailable}    ${SUITE_RESULTS_DIR}    2
    authenticate_image_with_reference    ${SUITE_RESULTS_DIR}    ${powerbase_controls_unavailable}.png    ${REFERENCES_DIR}    ${powerbase_controls_unavailable_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture  ${ssh}     ${reverse_gear}     ${SUITE_RESULTS_DIR}     2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${powerbase_controls_unavailable_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0    
    Sleep    2s
    Signal Dispatch    DrvrSeltdOtltOffPwrMdVirCtlAvl    0
    Sleep    4s
    Acquire Qnx Display Picture   ${ssh}    ${cancel_icon}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${cancel_icon}.png    ${REFERENCES_DIR}    ${cancel_icon_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2

TC_Camera_Interaction_Pop-UP_0028
    Set Mode    Propulsion
    Signal Dispatch    ESCLP_ElecStrgColLckStsAuth    1
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0
    Signal Dispatch    APAVMR_SloDnIndOn    1
    launch_app    ${controls_app}
    Sleep    2S
    Acquire Qnx Display Picture   ${ssh}    ${turn_on_powerbase_popup}    ${SUITE_RESULTS_DIR}    2
    ${result}    Extract Coordinates From Reference    ${SUITE_RESULTS_DIR}    ${turn_on_powerbase_popup}.png    ${REFERENCES_DIR}    ${auto_park_assist_screen_reference}.png
    qnx_screen_engage_touch_at    ${ssh}    ${result[0]}    ${result[1]}    2 
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${auto_park_assist}    ${SUITE_RESULTS_DIR}    2
    Authenticate Image With Reference     ${SUITE_RESULTS_DIR}    ${auto_park_assist}.png    ${REFERENCES_DIR}    ${auto_park_assist_reference}.png
    Sleep    2s 
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    3
    Sleep    2s
    Acquire Qnx Display Picture   ${ssh}    ${reverse_gear}    ${SUITE_RESULTS_DIR}    2
    Reference Image Not Found    ${SUITE_RESULTS_DIR}    ${reverse_gear}.png    ${REFERENCES_DIR}    ${auto_park_assist_reference}.png
    Signal Dispatch    VMMP_VehMtnMvmtStatAuth    0    
    Sleep    2s
    Signal Dispatch    APAVMR_SloDnIndOn    0
    

