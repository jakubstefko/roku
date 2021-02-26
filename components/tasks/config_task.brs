sub init()
    m.top.functionname = "load"
  end sub
  
  function load()
      data = ReadAsciiFile("pkg:/" + m.top.file_path)
      m.top.file_data = parseJSON(data)
  end function