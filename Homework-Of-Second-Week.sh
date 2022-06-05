###########################################
# Author : Rukiye AKINCI
# Date : 05/06/2022
# Subject : Git Bash Script (Second Week)
###########################################


#!/bin/bash

# Help fonksiyonu içine scripte istenilen özellikler tanımlandı

Help()
{
	echo
	echo "Usage:"
	echo "	-b <branch_name>	Branch name"
	echo "	-n <new_branch>		Create new branch"
	echo "	-f <zip|tar>		Compress format"
	echo "	-p <artifact_path>	Copy artifact to spesific path"
	echo "	-d <debug_mode>		Enable debug mode"
	echo
}


# Branch fonksiyonu içinde WARNING tanımlandı
Branch()
{
	if [ $1 == master ] || [ $1 == main ]
	then
		echo -e "\033[1;31mmaster yada main branch'ini build ediyorsunuz !!\033[0m"
	fi
	if [ $1 !=  $(git branch | awk '{print($2)}') ]
	then
		git checkout $1
	fi
	git add .
	git commit -m "Upload $(date)"
	git push
}


# NewBranch fonksiyonu içinde yeni branch oluşturulması sağlandı
NewBranch()
{
	# echo $1
	git checkout -b $1
}

while [[ "$#" -gt 0 ]]; do
	case $1 in
		-h|--help) Help; shift ;;
		-b*)
		if [[ "$1" != *=* ]]; then shift; fi
		Branch ${1#*=} ; shift ;;
		-n*)
		if [[ "$1" != *=* ]]; then shift; fi
		NewBranch ${1#*=} ; shift ;;
		*) echo "Belirsiz parametre: $1" ;;
	esac
	shift
done
