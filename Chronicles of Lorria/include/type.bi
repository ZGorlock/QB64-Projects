'primary windows type declarations
TYPE POINTL
    x AS LONG
    y AS LONG
END TYPE

'secondary windows type declarations
TYPE DEVMODE
    dmDeviceName AS STRING * 32
    dmSpecVersion AS _UNSIGNED INTEGER
    dmDriverVersion AS _UNSIGNED INTEGER
    dmSize AS _UNSIGNED INTEGER
    dmDriverExtra AS _UNSIGNED INTEGER
    dmFields AS _UNSIGNED LONG
    dmPosition AS POINTL
    dmDisplayOrientation AS _UNSIGNED LONG
    dmDisplayFixedOutput AS _UNSIGNED LONG
    dmColor AS INTEGER
    dmDuples AS INTEGER
    dmYResoluction AS INTEGER
    dmTTOption AS INTEGER
    dmCollate AS INTEGER
    dmFormName AS STRING * 32
    dmLogPixels AS _UNSIGNED INTEGER
    dmBitsPerPixel AS _UNSIGNED LONG
    dmPelsWidth AS _UNSIGNED LONG
    dmPelsHeight AS _UNSIGNED LONG
    dmDisplayFlags AS _UNSIGNED LONG
    dmDisplayFrequency AS _UNSIGNED LONG
    dmICMMethod AS _UNSIGNED LONG
    dmICMIntent AS _UNSIGNED LONG
    dmMediaType AS _UNSIGNED LONG
    dmDitherType AS _UNSIGNED LONG
    dmReserved1 AS _UNSIGNED LONG
    dmReserved2 AS _UNSIGNED LONG
    dmPlanningWidth AS _UNSIGNED LONG
    dmPlanningHeight AS _UNSIGNED LONG
END TYPE

'database type declarations
'$INCLUDE:'include\db\type.bi'

'custom type declarations
TYPE metrics
    sound AS _BYTE
    fx AS _BYTE
    lps AS _UNSIGNED INTEGER
    fps AS _UNSIGNED INTEGER
    ssloc AS STRING * 128
    cursor AS _BYTE
    cursorcolor AS _BYTE
    hidecursor AS _BYTE
    races AS STRING * 16
    scrollmultiplier AS _BYTE
END TYPE
TYPE outfit
    helm AS LONG
    body AS LONG
    leg AS LONG
    boot AS LONG
    glove AS LONG
    shield AS LONG
    weapon AS LONG
    belt AS LONG
    shoulder AS LONG
    mantle AS LONG
    pendant AS LONG
    lring AS LONG
    rring AS LONG
    earring AS LONG
    bracelet AS LONG
    other AS LONG
    tatoo AS LONG
END TYPE
TYPE character
    file AS STRING * 128
    name AS STRING * 32
    race AS STRING * 16
    gender AS STRING * 1
    class AS STRING * 16
    str AS _BYTE
    dex AS _BYTE
    int AS _BYTE
    wis AS _BYTE
    con AS _BYTE
    chr AS _BYTE
    alignment AS STRING * 32
    faction AS STRING * 32
END TYPE
TYPE monsterinstance
    monsternum AS LONG
    lv AS _UNSIGNED _BYTE
    alignment AS _UNSIGNED _BYTE
    type AS STRING * 16
    variation AS STRING * 40
    status AS STRING * 8
    locx AS LONG
    locy AS LONG
    memory AS _BYTE
    age AS LONG
    zoom AS SINGLE
    maxhealth AS LONG
    maxmana AS LONG
    maxstamina AS LONG
    health AS LONG
    mana AS LONG
    stamina AS LONG
    attack AS LONG
    defense AS LONG
    speed AS LONG
    intelligence AS _BYTE
    equipment AS outfit
    exp AS LONG
    gold AS LONG
    loot AS STRING * 4096 'loot(512, 2) AS _UNSIGNED LONG
    traindif AS _UNSIGNED _BYTE
    psionics AS _UNSIGNED _BYTE
END TYPE