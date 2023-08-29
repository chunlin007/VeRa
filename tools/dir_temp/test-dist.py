#! /usr/bin/env python3

if __name__ == "__main__":
	dict1 = [["Tom", [1, 2, 3]], ["LiMing", [2, 3, 5]]]
	for item in dict1:
		print(item[0], end=' ')
		print(item[1])
	dic1 = [1, 2]
	iname = "bit:" + "+".join([str(i).zfill(2) for i in dic1])
	print(iname)
	dic2 = {'bit:00,bit:01': True, 'bit:01,bit:01': True}
	for item in dic2.values():
		print(item)
		print(type(item))
	print("------------------------------")
	print(set(dic2.values()))
	if set(dic2.values()) == set([True]):
		print("yes")
	print("------------------------------")
	iname = ""
	for i in dic2.keys():
		if i.find(iname) == 0:
			print("YES")


