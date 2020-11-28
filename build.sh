cd BuildTools
curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
echo Enter the version: 
read Input
rm spigot*.jar
rm craftbukkit*.jar
java -jar BuildTools.jar --rev $Input --compile craftbukkit
mvn install:install-file \
   -Dfile=./craftbukkit-$Input.jar \
   -DgroupId=org.bukkit \
   -DartifactId=craftbukkit \
   -Dversion=$Input \
   -Dpackaging=jar \
   -DgeneratePom=true
java -jar BuildTools.jar --rev $Input
mvn install:install-file \
   -Dfile=./spigot-${Input}.jar \
   -DgroupId=org.spigotmc \
   -DartifactId=spigot-api \
   -Dversion=$Input \
   -Dpackaging=jar \
   -DgeneratePom=true
cp ./spigot*.jar ../spigot.jar
sleep