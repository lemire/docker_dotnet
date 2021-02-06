# docker_dotnet

Build and run .NET projects in a docker container. The provide script files will map the content of your disk so that the files you read from the container are the files on your disk, and the files you write get written to the disk. The container itself is effectively immutable.

Requirements:

- A working Docker system.
- The scripts are written using bash (available under Linux, macOS and so forth).


Usage:

1. Go to the directory where your project is in.

2. For that directory, invoke the script

```
 somepathtothefile/run_dotnet.sh bash
```

If you are lucky, you should enter into a bash shell from which you can compile and execute the C# code.

E.g., you can do

```
dotnet build myproject.sln
```


