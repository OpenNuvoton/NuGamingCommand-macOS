# NuGamingCommand-macOS
 
macOS 應用程式 NuGamingCommand Tool，這是一個為協助 Monitor 控制的 macOS Sample Tool，旨在協助如何在 macOS 下連接 NUC126 與如何讀寫相關控制 CMD。
以下是該應用程式的主要功能和特點：

1.USB HID的搜索與連接
透過白名單的方式，若符合相關 USB VID/PID 將會顯示在左上角的下拉式選單內，並可以選定後 Connect。
將可以參考這段程式碼進行在 macOS 上與 NUC126 的銜接開發。

2.使用json自動產生列表：
根據 FAE 反饋 Monitor 時常新增與修改相關CMD，為了提高修改的便利性，我們設計了一種透過 json自動產生列表與CMD Item的方式。
這使得使用者能夠輕鬆地增加、刪除、查詢和修改命令，而無需修改NuGamingCommand Too此應用程式。可以根據實際需求自行修改  json 內容，以滿足不同的應用場景。
我們可以看到右下的 Item List 即是透過 json 動態產生的，點選相關CMD可以看到右上角的Note欄裡提示了該CMD的相關information

3.GetCMD與SetCMD API功能：
應用程式內置了 GetCMD 與 SetCMD API功能，讓參考此 Sample 的使用者可以更簡單的透過API進行讀取與寫入相關CMD的動作。

<p float="left">
<img src="https://github.com/OpenNuvoton/NuGamingCommand-macOS/blob/main/image.png" alt="Cover" width="80%"/>
</p>
