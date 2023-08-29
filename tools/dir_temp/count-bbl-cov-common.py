#! /usr/bin/env python3
import json, os, time, subprocess, struct, ctypes, sys
MAP_SIZE = 1 << 21

def count_hash(addr1, addr2):
    h = addr1 * 31 + addr2
    h &= 0xffffffff
    h *= 0x85ebca6b
    h &= 0xffffffff
    h ^= h >> 13
    h &= 0xffffffff
    h *= 0xc2b2ae35
    h &= 0xffffffff
    h ^= h >> 16
    h &= 0xffffffff
    h &= (MAP_SIZE -1)
    return h

def bbl_cnt_part1(dirname):
    fname = "bbl_cov"
    bbl_cov_dic = {}
    bbl_sum = 0 
    for root, dirs, files in os.walk(dirname, topdown=True):
        if fname in files:
            fpath = '{0}/{1}'.format(root, fname)
            for k, v in list(json.load(open(fpath, "rb"))["bbl_cov"].items()):
                if k not in bbl_cov_dic:
                    bbl_cov_dic[k] = v
                    bbl_sum += 1
                else:
                    bbl_cov_dic[k] = bbl_cov_dic[k] + v
					
    return bbl_cov_dic


def bbl_cnt_part2(dirname, firmname):
    # create a new bitmap 2MB and store build info into it
    bitmap_bbl_temp = [ 0 for _ in range(MAP_SIZE) ]
    # peripheral model dir
    cnt1 = 0
    dir_model = "/root/" + dirname + "/" + firmname + "/1.0/"
    bbl_cov_dic = bbl_cnt_part1(dir_model)
    for k,v in list(bbl_cov_dic.items()):
        addr1 = int(k.split(',')[0][2:-1], 16)
        addr2 = int(k.split(',')[1][2:-2], 16)
        hash_val = count_hash(addr1, addr2)
        bitmap_bbl_temp[hash_val] = 1
        cnt1 += 1 
    #print("The num of basic block found during modeling: %d" % cnt1)
    
    # read bitmap_bbl file and abstract info of basic blocks
    cnt2 = 0
    file_bitmap = "/root/" + dirname + "/" + firmname + "/1.0/outputs/bitmap_bbl"
    if os.path.exists(file_bitmap):
        with open(file_bitmap, "rb") as file1:
            byte = file1.read(1)
            index = 0
            while index < MAP_SIZE:
                if struct.unpack('<B', byte)[0] != 0:
                    bitmap_bbl_temp[index] = 1
                    cnt2 += 1
                byte = file1.read(1)
                index += 1
    #print("The num of basic block found during fuzzing: %d" % cnt2)
    #else:
    	#print("Can not find %s" % file_bitmap)
    	
    cnt = 0
    for i in range(0, MAP_SIZE):
        if bitmap_bbl_temp[i] != 0:
    	    cnt += 1
    #print("The num of basic block found in all processing: %d" % cnt)
    return cnt

def get_fuzz_info(dirname, firmname):
    file_fuzz = "/root/" + dirname + "/" + firmname + "/1.0/outputs/fuzzer_stats"
    if os.path.exists(file_fuzz):
        with open(file_fuzz, "r") as file1:
            total_path = 0
            max_depth = 0
            list1 = file1.readlines()
            if list1 == []:
                return 0, 0
            for line in list1:
                if 'paths_total' in line:
                    total_path = int(line.split(':')[1].strip(), 10)
                if 'max_depth' in line:
                    max_depth = int(line.split(':')[1].strip(), 10)
                if total_path > 0 and max_depth > 0:
                    return total_path, max_depth
    else:
        return 0, 0



if __name__ == "__main__":

    print("Analyzing the basic blocks...")
    print("FirmName                 DICE(BBL|PATH|DEPTH)   SCOAE(BBL|PATH|DEPTH)   DIFF(BBL|PATH|DEPTH)")
    firm_dic1 = [
         "Modbus",
         "ModbusRedZones",
         "GuitarPedal",
         "GPSReceiver",
         "StepperMotor",
         "MIDISynthesizer",
         "Oscilloscope",
         "SolderingStation",
         "Gateway",
         "CNC",
         "Console",
         "Heat-Press",
         "Reflow-Oven",
         "Robot",
         "Steering-Control",
         "PLC",
         "Drone",
         "HeatGun",
         "NRF52832_I2s",
         "NRF52832_SPI_Master",
         "NRF52832_SPI_Slave",
         "NRF52832_Uart",
         "MIDISynthesizer-origin",
         "SolderingStation-origin",
         "StepperMotor-origin",
         "Soldering-Iron",
         "Spectrometer",
         "XML_Parser",
       	 "3Dprinter",
         "GPSTracker",
         "Zepyhr-SocketCan",
		 "WinUSB",
		 "Test"
	]
    firm_dic2 = [
        "Modbus",
        "Modbus-Redzones",
        "Guitar-Pedal",
        "GPS-Receiver",
        "Stepper-Motor",
        "MIDI-Synthesizer",
        "Oscilloscope",
        "Soldering-Station",
        "Gateway",
        "CNC",
        "Console",
        "Heat-Press",
        "Reflow-Oven",
        "Robot",
        "Steering-Control",
        "PLC",
        "Drone",
        "Heat-Gun",
        "NRF52832_I2s",
        "NRF52832_SPI_Master",
        "NRF52832_SPI_Slave",
        "NRF52832_Uart",
        "MIDI-Synthesizer-origin",
        "Soldering-Station-origin",
        "Stepper-Motor-origin",
        "Soldering-Iron",
        "Spectrometer",
        "XML_Parser",
       	"3Dprinter",
        "GPSTracker",
        "Zepyhr-SocketCan",
		"WinUSB",
		"Test"
	]
    if len(sys.argv) > 1:
        list_id = []
        for i in range(0, len(firm_dic1)):
            if firm_dic1[i] in sys.argv or firm_dic2[i] in sys.argv:
        	    list_id.append(i)
        for i in list_id:
            bbl_cnt1 = bbl_cnt_part2("FuzzBase1",firm_dic1[i])
            bbl_cnt2 = bbl_cnt_part2("FuzzBase2",firm_dic2[i])
            total_path1, max_depth1 = get_fuzz_info("FuzzBase1", firm_dic1[i])
            total_path2, max_depth2 = get_fuzz_info("FuzzBase2", firm_dic2[i])
            print("%-25s%-6d %-6d %-9d%-6d %-6d %-10d%-6d %-6d %-6d" % (firm_dic1[i], bbl_cnt1, total_path1, max_depth1, bbl_cnt2, total_path2, max_depth2, bbl_cnt2 - bbl_cnt1, total_path2 - total_path1, max_depth2 - max_depth1))
    	
    else:	
        for i in range(0, len(firm_dic1)):
            bbl_cnt1 = bbl_cnt_part2("FuzzBase1",firm_dic1[i])
            bbl_cnt2 = bbl_cnt_part2("FuzzBase2",firm_dic2[i])
            total_path1, max_depth1 = get_fuzz_info("FuzzBase1", firm_dic1[i])
            total_path2, max_depth2 = get_fuzz_info("FuzzBase2", firm_dic2[i])
            print("%-25s%-6d %-6d %-9d%-6d %-6d %-10d%-6d %-6d %-6d" % (firm_dic1[i], bbl_cnt1, total_path1, max_depth1, bbl_cnt2, total_path2, max_depth2, bbl_cnt2 - bbl_cnt1, total_path2 - total_path1, max_depth2 - max_depth1))

