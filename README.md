# docker_dotnet

Build and run .NET projects in a docker container. The provide script files will map the content of your disk so that the files you read from within the container are the files on your disk, and the files you write get written to the disk. The container itself is effectively immutable.

Requirements:

- A working Docker system under Linux or macOS.
- The scripts are written using bash (available under Linux, macOS and so forth).

*It is not meant to be used within Windows per se*.

Usage:

1. Go to the directory of your project.

2. From that directory, invoke the script

```
 somepathtothefile/run_dotnet.sh bash
```

You should enter into a bash shell from which you can compile and execute the C# code.

E.g., you can do

```
dotnet build myproject.sln
```


Tips:


1. Instead of passing 'bash' to the 'run_dotnet.sh', you can pass other commands instead.
2. You could put the script `run_dotnet.sh` in your PATH for convenience.
