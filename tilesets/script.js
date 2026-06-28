
WA.onInit().then(() => {
    console.log("Скрипт библиотеки загружен");

    
    bookZones.forEach((zone) => {
        let popup; 

       
        WA.room.onEnterZone(zone.name, () => {
           
            const bookText = zone.properties.text || "Эта книга пуста...";

          
            WA.ui.displayActionMessage({
                message: "Нажмите Пробел, чтобы прочитать",
                callback: () => {
                    // Если нажали пробел — открываем красивое окно
                    popup = WA.ui.openPopup(zone.name, bookText, [
                        {
                            label: "Закрыть",
                            className: "primary",
                            callback: (p) => {
                                p.close();
                            }
                        }
                    ]);
                }
            });
        });


        WA.room.onLeaveZone(zone.name, () => {
            WA.ui.hideActionMessage();
            if (popup) {
                popup.close();
            }
        });
    });
});