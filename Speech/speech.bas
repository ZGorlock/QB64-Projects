'this program requires the files that are attached to:
' http://www.qb64.net/forum/index.php?topic=4491.msg58252#msg58252

'code written by me is public domain, but it is partly derived from MinGW and Microsoft Speech API 5.1 SDK headers.
'2012 march, michael calkins

'$include:'peekpoke.bi'

CONST COINIT_MULTITHREADED = &H0
CONST COINIT_APARTMENTTHREADED = &H2
CONST COINIT_DISABLE_OLE1DDE = &H4
CONST COINIT_SPEED_OVER_MEMORY = &H8

CONST CLSCTX_INPROC_SERVER = &H1
CONST CLSCTX_INPROC_HANDLER = &H2
CONST CLSCTX_LOCAL_SERVER = &H4
CONST CLSCTX_REMOTE_SERVER = &H10

CONST CLSCTX_ALL = CLSCTX_INPROC_SERVER OR CLSCTX_INPROC_HANDLER OR CLSCTX_LOCAL_SERVER OR CLSCTX_REMOTE_SERVER

CONST sizeof_ptr = 4
CONST ISpVoice_QueryInterface = sizeof_ptr * 0 ' HRESULT ()(ISpVoice * This, REFIID riid, void **ppvObject)
CONST ISpVoice_AddRef = sizeof_ptr * 1 ' ULONG ()(ISpVoice * This)
CONST ISpVoice_Release = sizeof_ptr * 2 ' ULONG ()(ISpVoice * This)
CONST ISpVoice_SetNotifySink = sizeof_ptr * 3
CONST ISpVoice_SetNotifyWindowMessage = sizeof_ptr * 4
CONST ISpVoice_SetNotifyCallbackFunction = sizeof_ptr * 5
CONST ISpVoice_SetNotifyCallbackInterface = sizeof_ptr * 6
CONST ISpVoice_SetNotifyWin32Event = sizeof_ptr * 7
CONST ISpVoice_WaitForNotifyEvent = sizeof_ptr * 8
CONST ISpVoice_GetNotifyEventHandle = sizeof_ptr * 9
CONST ISpVoice_SetInterest = sizeof_ptr * 10
CONST ISpVoice_GetEvents = sizeof_ptr * 11
CONST ISpVoice_GetInfo = sizeof_ptr * 12
CONST ISpVoice_SetOutput = sizeof_ptr * 13
CONST ISpVoice_GetOutputObjectToken = sizeof_ptr * 14
CONST ISpVoice_GetOutputStream = sizeof_ptr * 15
CONST ISpVoice_Pause = sizeof_ptr * 16
CONST ISpVoice_Resume = sizeof_ptr * 17
CONST ISpVoice_SetVoice = sizeof_ptr * 18
CONST ISpVoice_GetVoice = sizeof_ptr * 19
CONST ISpVoice_Speak = sizeof_ptr * 20 ' HRESULT ()(ISpVoice * This, const WCHAR *pwcs, DWORD dwFlags, ULONG *pulStreamNumber)
CONST ISpVoice_SpeakStream = sizeof_ptr * 21
CONST ISpVoice_GetStatus = sizeof_ptr * 22
CONST ISpVoice_Skip = sizeof_ptr * 23
CONST ISpVoice_SetPriority = sizeof_ptr * 24
CONST ISpVoice_GetPriority = sizeof_ptr * 25
CONST ISpVoice_SetAlertBoundary = sizeof_ptr * 26
CONST ISpVoice_GetAlertBoundary = sizeof_ptr * 27
CONST ISpVoice_SetRate = sizeof_ptr * 28
CONST ISpVoice_GetRate = sizeof_ptr * 29
CONST ISpVoice_SetVolume = sizeof_ptr * 30
CONST ISpVoice_GetVolume = sizeof_ptr * 31
CONST ISpVoice_WaitUntilDone = sizeof_ptr * 32
CONST ISpVoice_SetSyncSpeakTimeout = sizeof_ptr * 33
CONST ISpVoice_GetSyncSpeakTimeout = sizeof_ptr * 34
CONST ISpVoice_SpeakCompleteEvent = sizeof_ptr * 35
CONST ISpVoice_IsUISupported = sizeof_ptr * 36
CONST ISpVoice_DisplayUI = sizeof_ptr * 37

CONST SPF_DEFAULT = 0
CONST SPF_ASYNC = 1
CONST SPF_PURGEBEFORESPEAK = 2
CONST SPF_IS_FILENAME = 4
CONST SPF_IS_XML = 8
CONST SPF_IS_NOT_XML = &H10
CONST SPF_PERSIST_XML = &H20
CONST SPF_NLP_SPEAK_PUNC = &H40
CONST SPF_NLP_MASK = SPF_NLP_SPEAK_PUNC
CONST SPF_VOICE_MASK = SPF_ASYNC OR SPF_PURGEBEFORESPEAK OR SPF_IS_FILENAME OR SPF_IS_XML OR SPF_IS_NOT_XML OR SPF_NLP_MASK OR SPF_PERSIST_XML
CONST SPF_UNUSED_FLAGS = NOT SPF_VOICE_MASK

DECLARE DYNAMIC LIBRARY "ole32"
    FUNCTION CoInitializeEx& (BYVAL pvReserved%&, BYVAL dwCoInit~&)
    SUB CoUninitialize ()
    FUNCTION CoCreateInstance& (BYVAL rclsid%&, BYVAL pUnkOuter%&, BYVAL dwClsContext&, BYVAL riid%&, BYVAL ppv%&)
END DECLARE

DECLARE CUSTOMTYPE LIBRARY "test_speak_qb64"
    FUNCTION dABSOLUTEp (BYVAL pf%&, BYVAL p0%&)
    SUB vABSOLUTEp ALIAS dABSOLUTEp (BYVAL pf%&, BYVAL p0%&)
    FUNCTION dABSOLUTEppdp~& (BYVAL pf%&, BYVAL v0%&, BYVAL v1%&, BYVAL v2~&, BYVAL v3%&)
END DECLARE

TYPE GUID
    Data1 AS _UNSIGNED LONG
    Data2 AS _UNSIGNED INTEGER
    Data3 AS _UNSIGNED INTEGER
    data4 AS _UNSIGNED _INTEGER64
END TYPE

DIM CLSID_SpVoice AS GUID
DIM IID_ISpvoice AS GUID
DIM pVoice AS _OFFSET
DIM t AS STRING
DIM ut AS STRING
DIM COMinit AS LONG
DIM Voiceinit AS LONG
DIM hr AS LONG
DIM i AS LONG

txt2guid _OFFSET(CLSID_SpVoice), "96749377-3391-11D2-9EE3-00C04F797396"
txt2guid _OFFSET(IID_ISpvoice), "6C44DF74-72B9-4992-A1EC-EF996E0422D4"

COMinit = -1
Voiceinit = -1

ON ERROR GOTO cleanup
IF _EXIT THEN GOTO cleanup

COMinit = CoInitializeEx(0, COINIT_MULTITHREADED OR COINIT_SPEED_OVER_MEMORY)
IF 0 > COMinit THEN 'sign bit indicates an error
    PRINT "CoInitialize failed: 0x" + hexd(COMinit)
    END
END IF

Voiceinit = CoCreateInstance(_OFFSET(CLSID_SpVoice), 0, CLSCTX_ALL, _OFFSET(IID_ISpvoice), _OFFSET(pVoice))
IF 0 > Voiceinit THEN
    PRINT "CoCreateInstance failed: 0x" + hexd(Voiceinit)
    GOTO cleanup
END IF

DO
    IF _EXIT THEN GOTO cleanup
    LINE INPUT "Text: ", t
    IF 0 = LEN(t) THEN EXIT DO
    ut = MKI$(0)
    FOR i = LEN(t) TO 1 STEP -1
        ut = MKI$(ASC(MID$(t, i, 1))) + ut
    NEXT
    hr = dABSOLUTEppdp(peekp(peekp(pVoice) + ISpVoice_Speak), pVoice, _OFFSET(ut), 0, 0)
    IF 0 > hr THEN
        PRINT " Speak failed: 0x" + hexd(hr)
    END IF
LOOP

cleanup:
IF 0 <= Voiceinit THEN PRINT "New reference count: 0x" + hexd(dABSOLUTEp(peekp(peekp(pVoice) + ISpVoice_Release), pVoice))
IF 0 <= COMinit THEN CoUninitialize
END

SUB txt2guid (c AS _OFFSET, t AS STRING)
'DIM d AS LONG
'DIM s AS LONG
DIM i AS LONG

poked c, VAL("&h" + LEFT$(t, 8))
pokew c + 4, VAL("&h" + MID$(t, 10, 4))
pokew c + 6, VAL("&h" + MID$(t, 15, 4))
pokeb c + 8, VAL("&h" + MID$(t, 20, 2))
pokeb c + 9, VAL("&h" + MID$(t, 22, 2))
FOR i = 0 TO 5
    pokeb c + 10 + i, VAL("&h" + MID$(t, 25 + i * 2, 2))
NEXT

's = 1
'FOR d = 0 TO &HF
'SELECT CASE s
' CASE 9, 14, 19, 24: s = s + 1
'END SELECT
'pokeb c + d, VAL("&h" + MID$(t, s, 2))
''s = s + 2
'NEXT
END SUB

'$include:'hexx.bi'