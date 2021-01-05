cd BuildTools
curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
echo Enter the version: 
read Input
rm spigot*.jar
rm craftbukkit*.jar
java -jar BuildTools.jar --rev $Input
cp ./spigot*.jar ../spigot.jar
(cd BuildData/CraftBukkit; mvn install)
(cd BuildData/Spigot/Spigot-Api; mvn install)