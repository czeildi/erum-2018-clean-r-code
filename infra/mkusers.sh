for userdetails in `cat /home/users.csv`
do
    user=`echo $userdetails | cut -f 1 -d ,`
	passwd=`echo $userdetails | cut -f 2 -d ,`
    useradd -m -g staff -p $(openssl passwd -1 $passwd) $user
done
