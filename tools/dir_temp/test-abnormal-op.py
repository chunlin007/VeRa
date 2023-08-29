#! /usr/bin/env python3

if __name__ == "__main__":
    dic1 = {}
    dic1["aaa"] = [1,2,3]
    dic1["bbb"] = [4,5]
    try:
        if len(dic1["ccc"]) > 0:
            print("OK")
    except KeyError:
        print("KeyError")
    else:
        print("Yes")
	
    if "aaa" in dic1:
        print("YR")
    if "ccc" not in dic1:
        print("YR2")
