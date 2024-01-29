# 2024 HPC-AI Winter Camp @ NTHU & NCHC
## Brief Introduction to Intel® VTune™ Profilers

Clone this repo:
```bash
git clone https://github.com/nevikw39/HPC-Winter-Camp-Profiling
```

Please be advised that, in the code blocks of this document, you should replace the variables start with `$` (like `$RESULT_DIR`) on your own.

## SSH X11 Forwarding

Allow you to open GUI application running remotely on local computer.

Prerequiste:
- **Linux**: Noting to do if X11 desktop has been installed
- **macOS**: Xquatrz is required
- **Windows**: Enable WSLg with WSL 2, or use other X11 server like VcXsrv, Xming or one within MobaXTerm

Then, before establishing SSH connection, add `-X -Y` options or set `ForwardX11Trusted yes`, `ForwardX11 yes` in your SSH config.

```bash
# Note the `-r` option and the `/' at the end of the path!!
ssh -X -Y $USER@clogin1.twnia.nchc.org.tw
# Use another login node
ssh -X -Y $USER@clogin2.twnia.nchc.org.tw
```

To check whether that works, you could open some X11 apps:

```bash
xclock
xcalc
xlogo
xeyes
```

## Set up Environments on Taiwania 1

Remember that there are 2 login nodes, `clogin1` (_clogin1.twnia.nchc.org.tw_ or _140.110.148.11_) and `clogin2` (_clogin2.twnia.nchc.org.tw_ or _140.110.148.12_)!!

```bash
# Load Intel Compiler
module load intel/2019_u5 
# ``Source'' VTune
. /pkg/intel/2019_u5/vtune_amplifier/amplxe-vars.sh
# Select locale
export LC_CTYPE=en_US
```

## Intel® VTune™ Amplifier’s Application Performance Snapshot

### Generate Results

APS would first create a directory containing results. By default, the directory would be named after date and time. It could be specified through `--result-dir=$RESULT_DIR` optionally.

```bash
aps $APPLICATION $APPLICATION_PARAMETERS
# or
aps --result-dir=$RESULT_DIR $APPLICATION $APPLICATION_PARAMETERS
```

### Convert Result to Report

Then, we need obtain the analysis report (in HTML) based on the result data. By default, the report would also be named after date and time. It could be specified via `-O $REPORT_FILE` optionally.

```bash
aps-report $RESULT_DIR
# or
aps-report $RESULT_DIR -O $REPORT_FILE
```

### Study the Report

There are 3 ways to view the report:

#### X11 Forwarding

If you have had X11 Forwarding set properly, you could start web browsers like FireFox:

```bash
firefox $REPORT_FILE
```

#### Copy Report Back to Local

Otherwise, you could download the HTML back to your own computer and open it. That could be done by VSCode, MobaXTerm or `scp`:

```bash
scp $USER@xdata1.twnia.nchc.org.tw:$PATH_TO_REPORT_FILE .
```

Note that if you upload your public SSH key to Taiwania 1, you could transfer data with `xdata1`, `xdata2` nodes without OTP!!

#### Launch Simple Server and Port Forwarding

Alternatively, you might launch a simple web server (like `python -m SimpleHTTPServer` or `python3 -m http.server`) on Taiwania 1. Nevertheless, there exists firewall blocking some traffic. So we should forward port with SSH. Choose a randome port or you would collide with others!!

## Intel® VTune™ Amplifier

Note that in newer version, `amplxe-cl` & `amplxe-gui` would be `vtune` & `vtune-gui`, respectively.

### Collect Data

Common available collect options:
- Hotspots (`hotspots`)
- Memory Consumption (`memory-consumption`)
- Microarchitecture Exploration (`uarch-exploration`)
- Memory Access (`memory-access`)
- Threading (`threading`)
- HPC Performance Characterization (`hpc-performance`)
- I/O (`io`)

```bash
amplxe-cl -collect $COLLECT_OPTION -r $RESULT_DIR $APPLICATION $APPLICATION_PARAMETERS
```

### View the Report

Similarly, there are also 3 approaches to open the reports.

#### X11 Forwarding

Again, if X11 Forwarding have been set properly, we could start the GUI:

```bash
amplxe-gui $RESULT_DIR
```

#### Install VTune™ Locally & Copy Report Back to Local

Otherwise, you could install [VTune™](https://www.intel.com/content/www/us/en/docs/vtune-profiler/installation-guide/2023-1/overview.html) on your own computer and then download the HTML back. Downloading could be done by VSCode, MobaXTerm or `scp`:

```bash
# Note the `-r` option and the `/' at the end of the path!!
scp -r $USER@xdata1.twnia.nchc.org.tw:$PATH_TO_RESULT_DIR/ .
# Use another data transfer node
scp -r $USER@xdata2.twnia.nchc.org.tw:$PATH_TO_RESULT_DIR/ .
```

Note that if you upload your public SSH key to Taiwania 1, you could transfer data with `xdata1`, `xdata2` nodes without OTP!!

#### Launch Backend and Port Forwarding

Alternatively, Intel® provides VTune™ backend (`amplxe-backend` or `vtune-backend`) which works just like a web server. We could lauch it on Taiwania 1. Again, due to the firewall, we should forward port with SSH.
