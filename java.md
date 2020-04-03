# Run class with main using maven

```
mvn clean compile
mvn exec:java -Dexec.mainClass="demo.Hello"
```

# Read file contents as String

```String content = new String (Files.readAllBytes(file.toPath()),Charset.forName("UTF-8")); // if not specified, uses windows-1552 on that platform```

# Write String to file

```Files.write(Paths.get("c:/output.txt"), content.getBytes());```

# JEnv
[Project Link](https://github.com/jenv/jenv)
```
eval "$(jenv init -)"
jenv doctor
jenv versions
jenv global
jenv global system
jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home
jenv global oracle64-1.8.0.201
```

# Instrumentation

[Agent Packaging](https://docs.oracle.com/javase/8/docs/api/java/lang/instrument/package-summary.html)

# Components
[Usage Tracker](https://docs.oracle.com/javacomponents/usage-tracker/overview/toc.htm)

# Weird
[Reflection inflation](https://stackoverflow.com/questions/6505274/what-for-sun-jvm-creates-instances-of-sun-reflect-delegatingclassloader-at-runti)
- turn inflation off for HotSpot by setting a large threshold value
```
java -Dsun.reflect.inflationThreshold=100000 -javaagent:agentx-1.0.jar -jar target/springboot_demo-0.0.1-SNAPSHOT.jar
```

# Trace JVM
- trace class loagind with -XX:+TraceClassLoading

# Conflict Resolution	
Maven shade vs Gradle shadow
[Gradle Shade Plugin - package relocation](https://imperceptiblethoughts.com/shadow/configuration/relocation/#filtering-relocation)
[Just package rename](https://github.com/Abnaxos/gradle-preshadow-plugin)

# ByteCode
[ByteCode Tutorial](https://www.jrebel.com/blog/java-bytecode-tutorial)

# Detect internal jdk apis usage
JDeps tool provided since jdk8 by Oracle
[Using JDeps](https://www.theserverside.com/tutorial/Use-the-Java-JDeps-tool-to-root-out-internal-API-calls)

# Add tools.jar to local maven repo
```
mvn install:install-file -DgroupId=com.sun -DartifactId=tools -Dversion=1.4.2 -Dpackaging=jar -Dfile=/path/to/file
```

