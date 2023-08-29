#! /usr/bin/env python3
import re

def cnt_bbl_cov(trace_f):
    bc = {}
    # bc = {(hex_str(bbl_s), hex_str(bbl_e)): cnt}
    bbls = re.findall('BBL \((0x[0-9a-f]+), (0x[0-9a-f]+)\)', open(trace_f).read())
    for bbl in bbls:
        if bbl in bc:
            bc[bbl] += 1
        else:
            bc[bbl] = 1
    return bc


if __name__ == "__main__":
	print("test")
	dic1 = {"12":["bit:12"], "34":["bit:34"]}
	for ii in list(dic1.values()):
		print(ii)
		print(ii[0])
	trace_f1 = "/tmp/trace-bit:01"	
	trace_f2 = "/tmp/trace-bit:02"
	bbl_cov_dic = {}
	bbl_cov_dic["bit:01"] = cnt_bbl_cov(trace_f1)
	bbl_cov_dic["bit:02"] = cnt_bbl_cov(trace_f2)
	print(bbl_cov_dic)
	fname_l = ["bit:01", "bit:02"]
	cov = []
	bbl_cov = {}
	for fname in fname_l:
		new_cov = []
		for k in bbl_cov_dic[fname]:
			print(k)
			#print(bbl_cov_dic[fname][k])
			if k not in bbl_cov:
				new_cov.append(k)
		cov.append(new_cov)
	print("---")
	print(max(cov))
	print(cov)
	cov1 = [[],[],[]]
	print(cov1)
	ll = [[1,2,3], [4,5]]
	print(max(ll))
	for i in range(0, 0):
		print(i)
	list1 = [1,2,4]
	list2 = [[1,2],[3,4]]
	print(len(list1))
	print(len(list2))
	term_cond = {}
	term_cond[0x21] = ["bit:01"]
	term_cond[0x21].append("bit:02")
	term_cond[0x21].append("bit:03")
	print(term_cond)
	print(term_cond[0x21])
	print("---------------")
	term_cond[0x23] = ["bit:05"]
	term_cond[0x23].append("bit:06")
	print(list(term_cond.keys()))
	print(list(term_cond.values()))
	cnt = []
	for v in list(term_cond.values()):
		cnt.append([len(v), v])
	print(cnt)
	bits = []
	for c in cnt:
		bits +=c[1]
	print(bits)
	print([12]+[23])
	print("------------------")
	arr1 = []
	arr2 = [[[-1]], [[7]]]
	arr3 = []
	for a in arr2:
		a.insert(0, 1)
	arr3 += arr2
	print(arr3)
	for a in arr3:
		a.insert(0,2)
	arr1 += arr3
	print(arr1)
	print("---------test---------")
	trace_sig = {
		"summary" : {
            "hash2" : [ [2], [3] ],
			"hash1" : [ [1] ],
            "hash3" : [ [4], [5], [6] ]
		}
	}
	'''
	trace_sig = {
		"summary" : {
			"hash1" : [ [1,2] ],
            "hash2" : [ [2,3], [3,4] ],
            "hash3" : [ [4,5], [5,6], [6,7] ]
		}
	}
	'''
	cnt1 = []
	for v in list(trace_sig["summary"].values()):
		print(v)
		cnt1.append([len(v), v])
	print(cnt1)
	bits1 = []
	for c in cnt1:
		print("==")
		print(c)
		print(c[1])
		bits1 += c[1]
	print(bits1)
	bits1.sort()
	print(bits1)
	print("------aaaa----------")
	prereq = {
		"hash1" : [ "fname1", "fname2" ],
		"hash2" : []
	}
	print(prereq)
	term = {}
	term[0x21] = ["fname1"]
	prereq["hash2"] += term[0x21]
	print(prereq)
	print("--------------")
	fname_l2 = ['name1', 'name2']
	fname_l2.remove('name1')
	print(fname_l2)
	dic11 = {"11": 12, "22": 22}
	del dic11["11"]
	print(dic11)
	print("--------------")
	pre = {
		"satisfy" : []
	}
	pre1 = {
		"satisfy" : []
	}
	term_srr_site = {}
	term_srr_site[0x11] = ["fname1"]
	term_srr_site[0x22] = ["fname2"]
	term_srr_site[0x11].append("fname3")
	print(term_srr_site)
	pre["satisfy"].append(list(term_srr_site.values())[0][0])
	pre1["satisfy"] += list(term_srr_site.values())[0]
	print(pre)
	print(pre1)
	fname11 = "bit:ab+cd,bit:AB"
	print(fname11.split(',')[0].strip("bit:"))
