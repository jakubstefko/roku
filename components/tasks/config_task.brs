sub init()
    m.top.functionname = "load"
end sub

function load()
    if m.top.file_path = ""
        m.top.error = "Brak ścieżki do pliku konfiguracyjnego"
    else
        data = ReadAsciiFile("pkg:/" + m.top.file_path)
        json = ParseJson(data)

        if json = invalid then
            m.top.error= "Nieprawidłowy plik konfiguracyjny"
        else
            m.top.file_data = json
        end if
    end if
end function