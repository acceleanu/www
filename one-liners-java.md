# Run class with main using maven

```
mvn clean compile
mvn exec:java -Dexec.mainClass="demo.Hello"
```

# Read file contents as String

```String content = new String (Files.readAllBytes(file.toPath()),Charset.forName("UTF-8")); // if not specified, uses windows-1552 on that platform```

# Write String to file

```Files.write(Paths.get("c:/output.txt"), content.getBytes());```



