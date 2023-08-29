#! /usr/bin/env python3

import os,sys
import configparser,argparse
from argparse import Namespace

def read_config(cfg_f):
    if not os.path.isfile(cfg_f):
        sys.exit("Cannot find the specified configuration file: %s" % cfg_f)
    parser = configparser.SafeConfigParser()
    parser.read(cfg_f)

    return Namespace(
        #bin_f    = "111"#os.path.abspath(parser.get("", "bin")),
        call_type    = parser.get("callback", "type"),
        call_hse     = parser.get("callback", "hse"),
        call_lse     = parser.get("callback", "lse"),
        call_jpg     = parser.get("callback", "jpg"),
        cap_family   = parser.get("capabilities", "family"),
        cap_hse      = parser.get("capabilities", "hse_freq_hz"),
        cap_lse      = parser.get("capabilities", "lse_freq_hz"),
        cap_eeprom   = parser.get("capabilities", "eeprom_size_kb"),
        cap_ccm      = parser.get("capabilities", "ccm_size_kb"),
    )


if __name__ == "__main__":

    cfg = read_config("./common_boards.cfg")
    print(cfg)
