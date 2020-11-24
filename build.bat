@echo off
IF NOT EXIST BuildTools (
    mkdir BuildTools
)
cd BuildTools
curl -z BuildTools.jar -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
set /p Input=Enter the version: || set Input=latest
del spigot*.jar
del craftbukkit*.jar
java -jar BuildTools.jar --rev %Input% --compile craftbukkit
echo "fixme"
call mvn install:install-file ^
   -Dfile=./craftbukkit-%Input%.jar ^
   -DgroupId=org.bukkit ^
   -DartifactId=craftbukkit ^
   -Dversion=%Input% ^
   -Dpackaging=jar ^
   -DgeneratePom=true
java -jar BuildTools.jar --rev %Input%
copy /b .\spigot*.jar ..\spigot.jar
pause