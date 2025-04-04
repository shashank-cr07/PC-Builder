import case_fan
import case
import cpu_cooler
import cpu
import external_hard_drive
import fan_controller
import internal_hard_drive
import memory
import motherboard
import osforpc
import power_supply
import thermal_paste
import video_card

case_fan.insert_csv_to_mysql("./csv/case-fan.csv")
case.insert_csv_to_mysql("./csv/case.csv")
cpu_cooler.insert_csv_to_mysql("./csv/cpu-cooler.csv")
cpu.insert_csv_to_mysql("./csv/cpu.csv")
external_hard_drive.insert_csv_to_mysql("./csv/external-hard-drive.csv")
fan_controller.insert_csv_to_mysql("./csv/fan-controller.csv")
internal_hard_drive.insert_csv_to_mysql("./csv/internal-hard-drive.csv")
memory.insert_csv_to_mysql("./csv/memory.csv")
motherboard.insert_csv_to_mysql("./csv/motherboard.csv")
osforpc.insert_csv_to_mysql("./csv/os.csv")
power_supply.insert_csv_to_mysql("./csv/power-supply.csv")
thermal_paste.insert_csv_to_mysql("./csv/thermal-paste.csv")
video_card.insert_csv_to_mysql("./csv/video-card.csv")