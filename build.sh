# remove temp directory if exist
if [ -d src ]
then
    echo "Deleting src........."
    rm -rf src
fi


echo "Cloning repo.........."
git clone https://github.com/Horsemens/Frontend.git  src/



docker login -u horsemens -p horsemen@123
docker build -t horsemens/django:1.0.0 .
docker push horsemens/django:1.0.0

if [ -d src ]
then
    echo "Deleting temp........."
    rm -rf temp
fi

echo "Done......................"