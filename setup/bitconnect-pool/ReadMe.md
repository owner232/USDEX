<b>HOW TO MINE USDE COIN?</b>

To Earn Block reward through PoW mining USDE Coin, follow the below steps:

<b>1. DOWNLOAD USDE WALLET FOR YOUR OPERATING SYSTEM.</b>

USDE coin uses a special algorithm called the POW/POS to secure the USDE Coin network.

In order to solo mine POW USDE coin, you’ll need a USDE coin wallet. You will need to wait for the blockchain to download if this is your first time using the wallet. Be patient it can take awhile.

Download the wallet software for Windows operating system. (Note: Guide on Linux, and OSX USDE Wallet available soon.)

<b>2. CONFIGURE</b>

In window, Open start menu, Search<b> %appdata%</b>, You can see <b>'roaming/USDE'</b> folder.

Close your wallet and create USDE.conf  by using notepad editor in <b>'roaming/USDE'</b> folder.

Simply copy and paste the following lines in <b>USDE.conf</b> file and save it.

rpcuser=Your_UserName
password=Your_Password
rpcallowip=127.0.0.1
rpcport=4210
listen=1
server=1
addnode=128.199.166.25
addnode=138.68.49.29
addnode=188.166.158.172
addnode=159.203.21.28

<i>Open USDE wallet by double click on <b>USDE.exe</b>.</i>

<b>3. SETUP MINER</b>
USDE coin can be mined with CPU/GPU and does not need an ASIC miner like Bitcoin does.

If you want to mine on a Windows Operating System, then you'll need to create your miner batch file to point to the wallet.

<ul>
<li>download zip file from github</li>
<li>Extract the zip file</li>
<li>Simply open notepad and then copy and paste the following line or Download this pre-configured RunMe.bat file and place it in your miners directory.
<br/>
<b>minerd --url=http://127.0.0.1:4210 --userpass=username:password</b>
</li>
</ul>

Now save the file as <b>"RunMe.bat"</b> in the same folder containing your miners application files. You are now ready to mine first POW USDE coin Block, double click on <b>"RunMe.bat"</b> to start mining.

<i>(Remember: When mining solo as mention earlier, it takes a bit of luck to 'find' block, but when you do solve block, all of the coins related to that block are yours to keep. While this is enticing for the beginner, you are better off mining in a pool.)</i>








