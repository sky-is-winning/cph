$scriptDir = $PSScriptRoot

$commands = @(
    "cd $scriptDir\houdini
    python bootstrap.py login",
    "cd $scriptDir\houdini
    python bootstrap.py world",
    "cd $scriptDir\dash
    python bootstrap.py -c config.py",
    "cd $scriptDir\web
    npm run start 80 local",
    "cd $scriptDir\snowflake
    python main.py",
    "websockify localhost:6113 localhost:6112",
    "websockify localhost:9876 localhost:9875"
)

$wtPath = "wt.exe"

foreach ($command in $commands) {
    Start-Process $wtPath -ArgumentList @("-w", "0", "new-tab", "powershell.exe", "-NoExit", "-Command", $command)
    Start-Sleep -Milliseconds 300
}
