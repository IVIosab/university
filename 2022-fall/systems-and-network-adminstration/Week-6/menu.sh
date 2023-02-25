#!/bin/bash
print_kernel ()
{
	echo "kernel name: $(uname -s)"
	echo "kernel version: $(uname -v)"
}

print_arch ()
{
	echo "system architecture: $(uname -m)"
}

print_users ()
{
	echo "currently logged in users: "
	echo "$(w)"
}

print_efi ()
{
	if efibootmgr | grep -q "EFI variables are not supported"; then 
		echo "EFI is not enabled"
	else 
		echo "EFI is enabled"
		echo $(efibootmgr)
	fi
}

print_devices ()
{
	echo "Block devices:"
	echo "$(lsblk)"
}

print_first_boot ()
{
	echo "$(efibootmgr | grep $(efibootmgr | awk '/BootCurrent/ {print $2}') -m3 | tail -n1)"
}

PS3='Please select a Choice: '
menu=("System information" "OS components" "Quit")
select opt in "${menu[@]}"
do 
	case $opt in 
		"System information")			
			echo "$opt: "
			select subopt in "Print OS kernel name and version" "Print system architecture" "View currently logged in users" "Main menu"
			do
				case $subopt in 
					"Print OS kernel name and version")
						print_kernel
						;;
					"Print system architecture")
						print_arch
						;;
					"View currently logged in users")
						print_users
						;;
					"Main menu") 
						break
						;;
					*) 
						echo "invalid option $REPLY"
						;;
				esac
			done
			;;
		"OS components")
			echo "$opt: "
			select subopt in "Check if EFI is enabled" "List all connected block devices" "List first boot device on the system" "Main menu"
			do
				case $subopt in 
					"Check if EFI is enabled")
						print_efi
						;;
					"List all connected block devices")
						print_devices
						;;
					"List first boot device on the system")
						print_first_boot
						;;
					"Main menu")
						break
						;;
					*)
						echo "invalid option $REPLY"
						;;
				esac
			done
			;;
		"Quit")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done

