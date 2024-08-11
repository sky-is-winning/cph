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
    "websockify 0.0.0.0:6113 localhost:6112 --key /etc/letsencrypt/live/cphistory.pw/privkey.pem --cert /etc/letsencrypt/live/cphistory.pw/fullchain.pem",
    "websockify 0.0.0.0:9876 localhost:9875 --key /etc/letsencrypt/live/cphistory.pw/privkey.pem --cert /etc/letsencrypt/live/cphistory.pw/fullchain.pem"
)

$wtPath = "wt.exe"

foreach ($command in $commands) {
    Start-Process $wtPath -ArgumentList @("-w", "0", "new-tab", "powershell.exe", "-NoExit", "-Command", $command)
    Start-Sleep -Milliseconds 300
}
