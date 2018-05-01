function log {
adb logcat | grep $1 | tee log_$1.log
}
alias ll="ls -al"
