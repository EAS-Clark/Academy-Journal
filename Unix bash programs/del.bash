mkdir -p ~/.waste

for var in $*
do
mv $var ~/.waste
done
