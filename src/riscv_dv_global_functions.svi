  // Format the string to a fixed length
  function automatic string format_string(string str, int len = 10);
    string formatted_str;
    formatted_str = {len{" "}};
    if(len < str.len()) return str;
    formatted_str = {str, formatted_str.substr(0, len - str.len() - 1)};
    return formatted_str;
  endfunction

  // Print the data in the following format
  // 0xabcd, 0x1234, 0x3334 ...
  function automatic string format_data(bit [7:0] data[], int unsigned byte_per_group = 4);
    string str;
    int cnt;
    str = "0x";
    foreach(data[i]) begin
      if((i % byte_per_group == 0) && (i != data.size() - 1) && (i != 0)) begin
        str = {str, ", 0x"};
      end
      str = {str, $sformatf("%2x", data[i])};
    end
    return str;
  endfunction
