chr=`pwd`/lofsdisk

sudo mkdir -p $chr/usr/bin/
sudo mkdir -p $chr/bin/
sudo mkdir -p $chr/lib64/

sudo cp -v /bin/bash $chr/bin/bash
sudo cp -v /bin/ls $chr/bin/ls
sudo cp -v /bin/cat $chr/bin/cat
sudo cp -v /bin/echo $chr/bin/echo

for cmd in /bin/bash /bin/ls /bin/cat /bin/echo
do
	list=$(ldd $cmd | egrep -o "/lib.*\.[0-9]")
	IFS=$`\n`
	echo $list | while read -r i; do sudo cp -v --parents "$i" "${chr}"; done
done

gcc ex2.c -o ex2.out

sudo bash -c "echo 'Mosab' > ${chr}/file1"
sudo bash -c "echo 'Mohamed' > ${chr}/file2"

sudo cp ex2.out $chr/ex2.out

echo "chroot" > ex2.txt
sudo chroot $chr ./ex2.out >> ex2.txt 
echo "actual root" >> ex2.txt
./ex2.out >> ex2.txt
