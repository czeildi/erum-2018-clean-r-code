for userdetails in `cat users.csv`
do
    user=`echo $userdetails | cut -f 2 -d ,`
	passwd=`echo $userdetails | cut -f 3 -d ,`
    useradd -m -g staff -p $(openssl passwd -1 $passwd) $user
done
