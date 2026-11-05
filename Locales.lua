-- InputSwap localization.
--
-- The English text is the lookup key (L["Some text"]). Translations are listed in the SAME ORDER as the
-- ENGLISH list below, one table per game locale. Anything missing falls back to English.
-- To add or fix a language, edit its table here and keep the %s / %d placeholders in the same order.

local ADDON, ns = ...

local ENGLISH = {
    "Gamepad UI",                                                                              -- 1
    "Mouse & keyboard UI",                                                                     -- 2
    "on",                                                                                      -- 3
    "off",                                                                                     -- 4
    "%s  |  current: %s  |  during combat: %s  |  min. time between switches: %ds",            -- 5
    "switch after combat",                                                                     -- 6
    "ignored",                                                                                 -- 7
    "Switches Gamepad UI automatically: left stick = Gamepad UI, your movement keys = mouse & keyboard UI.", -- 8
    "show status",                                                                             -- 9
    "enable or disable the addon",                                                             -- 10
    "switch to Gamepad UI / mouse & keyboard UI right now",                                    -- 11
    "toggle: ignore input in combat, or switch once combat ends",                              -- 12
    "minimum seconds between switches (default 3)",                                            -- 13
    "show or hide the minimap button",                                                         -- 14
    "open the options panel (Options > AddOns > InputSwap)",                                   -- 15
    "toggle debug messages (also: debug raw | debug keys | debug cvar [name])",                -- 16
    "show this list",                                                                          -- 17
    "enabled",                                                                                 -- 18
    "disabled",                                                                                -- 19
    "In combat, input is remembered and the switch happens when combat ends.",                 -- 20
    "Input is ignored during combat.",                                                         -- 21
    "minimum time between switches: %ds",                                                      -- 22
    "usage: /inputswap delay <seconds>",                                                       -- 23
    "options panel is not available in this client",                                           -- 24
    "unknown command '%s'. Type /inputswap help",                                              -- 25
    "minimap button shown",                                                                    -- 26
    "minimap button hidden",                                                                   -- 27
    "could not change %s: %s",                                                                 -- 28
    "Switches Enable Gamepad UI automatically based on how you last moved your character. Push the left stick for the Gamepad UI. Press a movement key for the mouse & keyboard UI.", -- 29
    "Current mode: %s",                                                                        -- 30
    "Enable automatic switching",                                                              -- 31
    "Turn InputSwap on or off. When off, the Gamepad UI setting is never changed by this addon.", -- 32
    "Switch after combat ends",                                                                -- 33
    "Unchecked: stick and keyboard input is ignored while you are in combat.",                 -- 34
    "Checked: the last input during combat is remembered and the switch happens when combat ends.", -- 35
    "Show minimap button",                                                                     -- 36
    "Shows a button on the minimap with the current mode. Left-click switches now, right-click opens these options, drag to move it.", -- 37
    "Minimum time between switches: %ds",                                                      -- 38
    "%ds",                                                                                     -- 39
    "Each switch reloads the UI, so this keeps an accidental bump of the stick or a key from causing repeated loading screens.", -- 40
    "Switch to Gamepad UI now",                                                                -- 41
    "Switch to Mouse & Keyboard now",                                                          -- 42
    "Switches immediately. The UI reloads.",                                                   -- 43
    "Slash commands: /inputswap help",                                                         -- 44
    "Current: %s",                                                                             -- 45
    "Automatic switching: %s",                                                                 -- 46
    "Left-click: switch to %s now",                                                            -- 47
    "Right-click: options",                                                                    -- 48
    "Drag: move this button",                                                                  -- 49
}

local TRANSLATIONS = {}

TRANSLATIONS.deDE = {
    "Gamepad-UI", "Maus- & Tastatur-UI", "an", "aus",
    "%s  |  aktuell: %s  |  im Kampf: %s  |  min. Zeit zwischen Wechseln: %ds",
    "nach dem Kampf wechseln", "ignoriert",
    "Schaltet die Gamepad-UI automatisch um: linker Stick = Gamepad-UI, deine Bewegungstasten = Maus- & Tastatur-UI.",
    "Status anzeigen", "Addon aktivieren oder deaktivieren",
    "sofort zur Gamepad-UI / Maus- & Tastatur-UI wechseln",
    "Umschalten: Eingaben im Kampf ignorieren oder nach dem Kampf wechseln",
    "Mindestsekunden zwischen Wechseln (Standard 3)",
    "Minimap-Button ein- oder ausblenden",
    "Optionsfenster öffnen (Optionen > AddOns > InputSwap)",
    "Debug-Meldungen umschalten (auch: debug raw | debug keys | debug cvar [Name])",
    "diese Liste anzeigen", "aktiviert", "deaktiviert",
    "Im Kampf werden Eingaben gemerkt, der Wechsel erfolgt nach dem Kampf.",
    "Eingaben werden im Kampf ignoriert.",
    "Mindestzeit zwischen Wechseln: %ds",
    "Verwendung: /inputswap delay <Sekunden>",
    "Das Optionsfenster ist in diesem Client nicht verfügbar",
    "Unbekannter Befehl '%s'. Gib /inputswap help ein",
    "Minimap-Button angezeigt", "Minimap-Button ausgeblendet",
    "%s konnte nicht geändert werden: %s",
    "Schaltet „Gamepad-UI aktivieren“ automatisch um, je nachdem, wie du deinen Charakter zuletzt bewegt hast. Linker Stick für die Gamepad-UI, Bewegungstaste für die Maus- & Tastatur-UI.",
    "Aktueller Modus: %s",
    "Automatisches Umschalten aktivieren",
    "Schaltet InputSwap ein oder aus. Wenn deaktiviert, ändert dieses Addon die Gamepad-UI-Einstellung nie.",
    "Nach dem Kampf wechseln",
    "Nicht aktiviert: Stick- und Tastatureingaben werden im Kampf ignoriert.",
    "Aktiviert: Die letzte Eingabe im Kampf wird gemerkt und der Wechsel erfolgt nach dem Kampf.",
    "Minimap-Button anzeigen",
    "Zeigt einen Button an der Minimap mit dem aktuellen Modus. Linksklick wechselt sofort, Rechtsklick öffnet diese Optionen, ziehen zum Verschieben.",
    "Mindestzeit zwischen Wechseln: %ds", "%ds",
    "Jeder Wechsel lädt die UI neu. So verursachen ein versehentlicher Stick- oder Tastenanstoß keine wiederholten Ladebildschirme.",
    "Jetzt zur Gamepad-UI wechseln", "Jetzt zu Maus & Tastatur wechseln",
    "Wechselt sofort. Die UI wird neu geladen.",
    "Slash-Befehle: /inputswap help",
    "Aktuell: %s", "Automatisches Umschalten: %s",
    "Linksklick: jetzt zu %s wechseln", "Rechtsklick: Optionen", "Ziehen: Button verschieben",
}

TRANSLATIONS.esES = {
    "IU de mando", "IU de ratón y teclado", "activado", "desactivado",
    "%s  |  actual: %s  |  en combate: %s  |  tiempo mín. entre cambios: %ds",
    "cambiar al terminar el combate", "ignorado",
    "Cambia la IU de mando automáticamente: stick izquierdo = IU de mando, tus teclas de movimiento = IU de ratón y teclado.",
    "mostrar el estado", "activar o desactivar el addon",
    "cambiar ahora a la IU de mando / de ratón y teclado",
    "alternar: ignorar la entrada en combate o cambiar al terminar el combate",
    "segundos mínimos entre cambios (por defecto 3)",
    "mostrar u ocultar el botón del minimapa",
    "abrir el panel de opciones (Opciones > Addons > InputSwap)",
    "alternar mensajes de depuración (también: debug raw | debug keys | debug cvar [nombre])",
    "mostrar esta lista", "activado", "desactivado",
    "En combate, la entrada se recuerda y el cambio se hace al terminar el combate.",
    "La entrada se ignora durante el combate.",
    "tiempo mínimo entre cambios: %ds",
    "uso: /inputswap delay <segundos>",
    "el panel de opciones no está disponible en este cliente",
    "comando desconocido '%s'. Escribe /inputswap help",
    "botón del minimapa mostrado", "botón del minimapa oculto",
    "no se pudo cambiar %s: %s",
    "Activa o desactiva automáticamente la IU de mando según cómo moviste por última vez a tu personaje. Empuja el stick izquierdo para la IU de mando. Pulsa una tecla de movimiento para la IU de ratón y teclado.",
    "Modo actual: %s",
    "Activar el cambio automático",
    "Activa o desactiva InputSwap. Si está desactivado, este addon nunca cambia el ajuste de la IU de mando.",
    "Cambiar al terminar el combate",
    "Sin marcar: la entrada del stick y del teclado se ignora durante el combate.",
    "Marcado: se recuerda la última entrada durante el combate y el cambio se hace al terminar.",
    "Mostrar el botón del minimapa",
    "Muestra un botón en el minimapa con el modo actual. Clic izquierdo cambia ahora, clic derecho abre estas opciones, arrastra para moverlo.",
    "Tiempo mínimo entre cambios: %ds", "%ds",
    "Cada cambio recarga la IU, así un toque accidental del stick o de una tecla no provoca pantallas de carga repetidas.",
    "Cambiar ahora a la IU de mando", "Cambiar ahora a ratón y teclado",
    "Cambia al instante. La IU se recarga.",
    "Comandos: /inputswap help",
    "Actual: %s", "Cambio automático: %s",
    "Clic izquierdo: cambiar ahora a %s", "Clic derecho: opciones", "Arrastrar: mover este botón",
}
TRANSLATIONS.esMX = TRANSLATIONS.esES

TRANSLATIONS.frFR = {
    "interface manette", "interface souris et clavier", "activé", "désactivé",
    "%s  |  actuel : %s  |  en combat : %s  |  délai min. entre changements : %ds",
    "changer après le combat", "ignorée",
    "Bascule automatiquement l'interface manette : stick gauche = interface manette, vos touches de déplacement = interface souris et clavier.",
    "afficher l'état", "activer ou désactiver l'addon",
    "passer tout de suite à l'interface manette / souris et clavier",
    "basculer : ignorer les entrées en combat, ou changer à la fin du combat",
    "secondes minimum entre changements (3 par défaut)",
    "afficher ou masquer le bouton de la minicarte",
    "ouvrir le panneau d'options (Options > AddOns > InputSwap)",
    "activer/désactiver les messages de débogage (aussi : debug raw | debug keys | debug cvar [nom])",
    "afficher cette liste", "activé", "désactivé",
    "En combat, l'entrée est mémorisée et le changement a lieu à la fin du combat.",
    "L'entrée est ignorée pendant le combat.",
    "délai minimum entre changements : %ds",
    "utilisation : /inputswap delay <secondes>",
    "le panneau d'options n'est pas disponible dans ce client",
    "commande inconnue '%s'. Tapez /inputswap help",
    "bouton de la minicarte affiché", "bouton de la minicarte masqué",
    "impossible de modifier %s : %s",
    "Active ou désactive automatiquement l'interface manette selon la dernière façon dont vous avez déplacé votre personnage. Poussez le stick gauche pour l'interface manette. Appuyez sur une touche de déplacement pour l'interface souris et clavier.",
    "Mode actuel : %s",
    "Activer le changement automatique",
    "Active ou désactive InputSwap. Désactivé, cet addon ne modifie jamais le réglage de l'interface manette.",
    "Changer après le combat",
    "Décoché : les entrées du stick et du clavier sont ignorées en combat.",
    "Coché : la dernière entrée en combat est mémorisée et le changement a lieu à la fin du combat.",
    "Afficher le bouton de la minicarte",
    "Affiche un bouton sur la minicarte avec le mode actuel. Clic gauche : changer maintenant, clic droit : ouvrir ces options, glisser pour le déplacer.",
    "Délai minimum entre changements : %ds", "%ds",
    "Chaque changement recharge l'interface ; cela évite qu'un faux mouvement du stick ou d'une touche provoque des écrans de chargement répétés.",
    "Passer à l'interface manette", "Passer à souris et clavier",
    "Change immédiatement. L'interface est rechargée.",
    "Commandes : /inputswap help",
    "Actuel : %s", "Changement automatique : %s",
    "Clic gauche : passer maintenant à %s", "Clic droit : options", "Glisser : déplacer ce bouton",
}

TRANSLATIONS.itIT = {
    "IU gamepad", "IU mouse e tastiera", "attivo", "disattivo",
    "%s  |  attuale: %s  |  in combattimento: %s  |  tempo min. tra cambi: %ds",
    "cambia dopo il combattimento", "ignorato",
    "Cambia automaticamente l'IU gamepad: stick sinistro = IU gamepad, tasti di movimento = IU mouse e tastiera.",
    "mostra lo stato", "attiva o disattiva l'addon",
    "passa subito all'IU gamepad / mouse e tastiera",
    "alterna: ignora l'input in combattimento oppure cambia al termine del combattimento",
    "secondi minimi tra i cambi (predefinito 3)",
    "mostra o nascondi il pulsante della minimappa",
    "apri il pannello delle opzioni (Opzioni > AddOn > InputSwap)",
    "attiva/disattiva i messaggi di debug (anche: debug raw | debug keys | debug cvar [nome])",
    "mostra questo elenco", "attivato", "disattivato",
    "In combattimento l'input viene ricordato e il cambio avviene al termine del combattimento.",
    "L'input viene ignorato durante il combattimento.",
    "tempo minimo tra i cambi: %ds",
    "uso: /inputswap delay <secondi>",
    "il pannello delle opzioni non è disponibile in questo client",
    "comando sconosciuto '%s'. Digita /inputswap help",
    "pulsante della minimappa mostrato", "pulsante della minimappa nascosto",
    "impossibile modificare %s: %s",
    "Attiva o disattiva automaticamente l'IU gamepad in base a come hai mosso per ultimo il personaggio. Spingi lo stick sinistro per l'IU gamepad. Premi un tasto di movimento per l'IU mouse e tastiera.",
    "Modalità attuale: %s",
    "Attiva il cambio automatico",
    "Attiva o disattiva InputSwap. Se disattivato, questo addon non modifica mai l'impostazione dell'IU gamepad.",
    "Cambia dopo il combattimento",
    "Non selezionato: l'input di stick e tastiera viene ignorato in combattimento.",
    "Selezionato: l'ultimo input in combattimento viene ricordato e il cambio avviene al termine.",
    "Mostra il pulsante della minimappa",
    "Mostra un pulsante sulla minimappa con la modalità attuale. Clic sinistro: cambia ora, clic destro: apre queste opzioni, trascina per spostarlo.",
    "Tempo minimo tra i cambi: %ds", "%ds",
    "Ogni cambio ricarica l'IU, così un tocco accidentale dello stick o di un tasto non causa schermate di caricamento ripetute.",
    "Passa ora all'IU gamepad", "Passa ora a mouse e tastiera",
    "Cambia subito. L'IU viene ricaricata.",
    "Comandi: /inputswap help",
    "Attuale: %s", "Cambio automatico: %s",
    "Clic sinistro: passa ora a %s", "Clic destro: opzioni", "Trascina: sposta questo pulsante",
}

TRANSLATIONS.ptBR = {
    "IU de controle", "IU de mouse e teclado", "ligado", "desligado",
    "%s  |  atual: %s  |  em combate: %s  |  tempo mín. entre trocas: %ds",
    "trocar após o combate", "ignorado",
    "Troca a IU de controle automaticamente: analógico esquerdo = IU de controle, suas teclas de movimento = IU de mouse e teclado.",
    "mostrar o status", "ativar ou desativar o addon",
    "trocar agora para a IU de controle / mouse e teclado",
    "alternar: ignorar entradas em combate ou trocar quando o combate terminar",
    "segundos mínimos entre trocas (padrão 3)",
    "mostrar ou ocultar o botão do minimapa",
    "abrir o painel de opções (Opções > AddOns > InputSwap)",
    "alternar mensagens de depuração (também: debug raw | debug keys | debug cvar [nome])",
    "mostrar esta lista", "ativado", "desativado",
    "Em combate, a entrada é lembrada e a troca acontece quando o combate terminar.",
    "A entrada é ignorada durante o combate.",
    "tempo mínimo entre trocas: %ds",
    "uso: /inputswap delay <segundos>",
    "o painel de opções não está disponível neste cliente",
    "comando desconhecido '%s'. Digite /inputswap help",
    "botão do minimapa exibido", "botão do minimapa oculto",
    "não foi possível alterar %s: %s",
    "Ativa ou desativa automaticamente a IU de controle conforme a última forma como você moveu seu personagem. Empurre o analógico esquerdo para a IU de controle. Pressione uma tecla de movimento para a IU de mouse e teclado.",
    "Modo atual: %s",
    "Ativar troca automática",
    "Liga ou desliga o InputSwap. Desligado, este addon nunca altera a configuração da IU de controle.",
    "Trocar após o combate",
    "Desmarcado: entradas do analógico e do teclado são ignoradas em combate.",
    "Marcado: a última entrada em combate é lembrada e a troca acontece quando o combate terminar.",
    "Mostrar botão do minimapa",
    "Mostra um botão no minimapa com o modo atual. Clique esquerdo troca agora, clique direito abre estas opções, arraste para mover.",
    "Tempo mínimo entre trocas: %ds", "%ds",
    "Cada troca recarrega a IU, então um toque acidental no analógico ou em uma tecla não causa telas de carregamento repetidas.",
    "Trocar agora para a IU de controle", "Trocar agora para mouse e teclado",
    "Troca imediatamente. A IU é recarregada.",
    "Comandos: /inputswap help",
    "Atual: %s", "Troca automática: %s",
    "Clique esquerdo: trocar agora para %s", "Clique direito: opções", "Arrastar: mover este botão",
}

TRANSLATIONS.ruRU = {
    "интерфейс геймпада", "интерфейс мыши и клавиатуры", "вкл.", "выкл.",
    "%s  |  сейчас: %s  |  в бою: %s  |  мин. интервал между переключениями: %d с",
    "переключать после боя", "игнорируется",
    "Автоматически переключает интерфейс геймпада: левый стик = интерфейс геймпада, клавиши движения = интерфейс мыши и клавиатуры.",
    "показать состояние", "включить или выключить аддон",
    "сразу переключиться на интерфейс геймпада / мыши и клавиатуры",
    "переключатель: игнорировать ввод в бою или переключаться после боя",
    "минимум секунд между переключениями (по умолчанию 3)",
    "показать или скрыть кнопку у миникарты",
    "открыть панель настроек (Настройки > Модификации > InputSwap)",
    "включить или выключить отладочные сообщения (также: debug raw | debug keys | debug cvar [имя])",
    "показать этот список", "включено", "выключено",
    "В бою ввод запоминается, а переключение происходит после боя.",
    "Во время боя ввод игнорируется.",
    "минимальный интервал между переключениями: %d с",
    "использование: /inputswap delay <секунды>",
    "панель настроек недоступна в этом клиенте",
    "неизвестная команда '%s'. Введите /inputswap help",
    "кнопка у миникарты показана", "кнопка у миникарты скрыта",
    "не удалось изменить %s: %s",
    "Автоматически включает и выключает интерфейс геймпада в зависимости от того, как вы в последний раз двигали персонажа. Отклоните левый стик — интерфейс геймпада. Нажмите клавишу движения — интерфейс мыши и клавиатуры.",
    "Текущий режим: %s",
    "Включить автоматическое переключение",
    "Включает или выключает InputSwap. Когда выключено, аддон никогда не меняет настройку интерфейса геймпада.",
    "Переключать после боя",
    "Не отмечено: ввод со стика и клавиатуры в бою игнорируется.",
    "Отмечено: последний ввод в бою запоминается, а переключение происходит после боя.",
    "Показывать кнопку у миникарты",
    "Показывает у миникарты кнопку с текущим режимом. ЛКМ — переключить сейчас, ПКМ — открыть эти настройки, перетащите, чтобы переместить.",
    "Минимальный интервал между переключениями: %d с", "%d с",
    "Каждое переключение перезагружает интерфейс, поэтому случайное касание стика или клавиши не вызывает повторных экранов загрузки.",
    "Переключиться на интерфейс геймпада", "Переключиться на мышь и клавиатуру",
    "Переключает сразу. Интерфейс перезагружается.",
    "Команды: /inputswap help",
    "Сейчас: %s", "Автоматическое переключение: %s",
    "ЛКМ: переключиться на %s", "ПКМ: настройки", "Перетащите, чтобы переместить кнопку",
}

TRANSLATIONS.koKR = {
    "게임패드 UI", "마우스/키보드 UI", "켜짐", "꺼짐",
    "%s  |  현재: %s  |  전투 중: %s  |  최소 전환 간격: %d초",
    "전투 후 전환", "무시",
    "게임패드 UI를 자동으로 전환합니다: 왼쪽 스틱 = 게임패드 UI, 이동 키 = 마우스/키보드 UI.",
    "상태 표시", "애드온 켜기/끄기",
    "지금 바로 게임패드 UI / 마우스/키보드 UI로 전환",
    "전환: 전투 중 입력을 무시하거나 전투가 끝나면 전환",
    "전환 사이 최소 시간(초, 기본 3)",
    "미니맵 버튼 표시/숨기기",
    "설정 창 열기 (설정 > 애드온 > InputSwap)",
    "디버그 메시지 전환 (추가: debug raw | debug keys | debug cvar [이름])",
    "이 목록 표시", "켜짐", "꺼짐",
    "전투 중에는 입력을 기억해 두었다가 전투가 끝나면 전환합니다.",
    "전투 중에는 입력을 무시합니다.",
    "최소 전환 간격: %d초",
    "사용법: /inputswap delay <초>",
    "이 클라이언트에서는 설정 창을 사용할 수 없습니다",
    "알 수 없는 명령어 '%s'. /inputswap help 를 입력하세요",
    "미니맵 버튼 표시됨", "미니맵 버튼 숨김",
    "%s 을(를) 변경할 수 없습니다: %s",
    "마지막으로 캐릭터를 움직인 방식에 따라 게임패드 UI 사용을 자동으로 켜고 끕니다. 왼쪽 스틱을 밀면 게임패드 UI, 이동 키를 누르면 마우스/키보드 UI가 됩니다.",
    "현재 모드: %s",
    "자동 전환 사용",
    "InputSwap을 켜거나 끕니다. 끄면 이 애드온은 게임패드 UI 설정을 절대 바꾸지 않습니다.",
    "전투 후 전환",
    "해제: 전투 중에는 스틱과 키보드 입력을 무시합니다.",
    "선택: 전투 중 마지막 입력을 기억해 두었다가 전투가 끝나면 전환합니다.",
    "미니맵 버튼 표시",
    "현재 모드를 보여 주는 버튼을 미니맵에 표시합니다. 좌클릭은 즉시 전환, 우클릭은 이 설정 열기, 드래그로 이동합니다.",
    "전환 사이 최소 시간: %d초", "%d초",
    "전환할 때마다 UI가 다시 불러와지므로, 스틱이나 키를 실수로 건드려도 로딩 화면이 반복되지 않게 합니다.",
    "지금 게임패드 UI로 전환", "지금 마우스/키보드로 전환",
    "즉시 전환합니다. UI가 다시 불러와집니다.",
    "명령어: /inputswap help",
    "현재: %s", "자동 전환: %s",
    "좌클릭: 지금 %s(으)로 전환", "우클릭: 설정", "드래그: 이 버튼 이동",
}

TRANSLATIONS.zhCN = {
    "手柄界面", "鼠标键盘界面", "开", "关",
    "%s  |  当前：%s  |  战斗中：%s  |  最短切换间隔：%d秒",
    "战斗结束后切换", "忽略",
    "自动切换手柄界面：左摇杆 = 手柄界面，移动按键 = 鼠标键盘界面。",
    "显示状态", "启用或禁用插件",
    "立即切换到手柄界面 / 鼠标键盘界面",
    "切换：战斗中忽略输入，或在战斗结束后切换",
    "两次切换之间的最短秒数（默认 3）",
    "显示或隐藏小地图按钮",
    "打开选项面板（选项 > 插件 > InputSwap）",
    "切换调试信息（另有：debug raw | debug keys | debug cvar [名称]）",
    "显示此列表", "已启用", "已禁用",
    "战斗中会记住输入，并在战斗结束后切换。",
    "战斗中忽略输入。",
    "最短切换间隔：%d秒",
    "用法：/inputswap delay <秒数>",
    "此客户端不支持选项面板",
    "未知命令“%s”。请输入 /inputswap help",
    "已显示小地图按钮", "已隐藏小地图按钮",
    "无法更改 %s：%s",
    "根据你最后一次移动角色的方式，自动开启或关闭手柄界面。推动左摇杆使用手柄界面，按下移动按键使用鼠标键盘界面。",
    "当前模式：%s",
    "启用自动切换",
    "开启或关闭 InputSwap。关闭后，此插件不会更改手柄界面设置。",
    "战斗结束后切换",
    "未勾选：战斗中忽略摇杆和键盘输入。",
    "已勾选：记住战斗中的最后一次输入，并在战斗结束后切换。",
    "显示小地图按钮",
    "在小地图上显示当前模式的按钮。左键立即切换，右键打开这些选项，拖动可移动。",
    "最短切换间隔：%d秒", "%d秒",
    "每次切换都会重新加载界面，因此不小心碰到摇杆或按键也不会反复出现加载画面。",
    "立即切换到手柄界面", "立即切换到鼠标键盘",
    "立即切换，界面将重新加载。",
    "命令：/inputswap help",
    "当前：%s", "自动切换：%s",
    "左键：立即切换到%s", "右键：选项", "拖动：移动此按钮",
}

TRANSLATIONS.zhTW = {
    "手把介面", "滑鼠鍵盤介面", "開", "關",
    "%s  |  目前：%s  |  戰鬥中：%s  |  最短切換間隔：%d秒",
    "戰鬥結束後切換", "忽略",
    "自動切換手把介面：左搖桿 = 手把介面，移動按鍵 = 滑鼠鍵盤介面。",
    "顯示狀態", "啟用或停用插件",
    "立即切換到手把介面 / 滑鼠鍵盤介面",
    "切換：戰鬥中忽略輸入，或在戰鬥結束後切換",
    "兩次切換之間的最短秒數（預設 3）",
    "顯示或隱藏小地圖按鈕",
    "開啟選項面板（選項 > 插件 > InputSwap）",
    "切換除錯訊息（另有：debug raw | debug keys | debug cvar [名稱]）",
    "顯示此清單", "已啟用", "已停用",
    "戰鬥中會記住輸入，並在戰鬥結束後切換。",
    "戰鬥中忽略輸入。",
    "最短切換間隔：%d秒",
    "用法：/inputswap delay <秒數>",
    "此客戶端不支援選項面板",
    "未知指令「%s」。請輸入 /inputswap help",
    "已顯示小地圖按鈕", "已隱藏小地圖按鈕",
    "無法變更 %s：%s",
    "依據你最後一次移動角色的方式，自動開啟或關閉手把介面。推動左搖桿使用手把介面，按下移動按鍵使用滑鼠鍵盤介面。",
    "目前模式：%s",
    "啟用自動切換",
    "開啟或關閉 InputSwap。關閉後，此插件不會變更手把介面設定。",
    "戰鬥結束後切換",
    "未勾選：戰鬥中忽略搖桿和鍵盤輸入。",
    "已勾選：記住戰鬥中的最後一次輸入，並在戰鬥結束後切換。",
    "顯示小地圖按鈕",
    "在小地圖上顯示目前模式的按鈕。左鍵立即切換，右鍵開啟這些選項，拖曳可移動。",
    "最短切換間隔：%d秒", "%d秒",
    "每次切換都會重新載入介面，因此不小心碰到搖桿或按鍵也不會反覆出現載入畫面。",
    "立即切換到手把介面", "立即切換到滑鼠鍵盤",
    "立即切換，介面將重新載入。",
    "指令：/inputswap help",
    "目前：%s", "自動切換：%s",
    "左鍵：立即切換到%s", "右鍵：選項", "拖曳：移動此按鈕",
}

-- Lookup table: L["English text"] -> translated text, or the English text itself when there is none.
local L = setmetatable({}, { __index = function(_, key) return key end })

local translated = TRANSLATIONS[GetLocale()]
if translated then
    for i, english in ipairs(ENGLISH) do
        if translated[i] then L[english] = translated[i] end
    end
end

ns.L = L
ns.localeData = { english = ENGLISH, translations = TRANSLATIONS }   -- used by the automated tests
