local source = {}

local utf = require'lua-utf8'

local keys = {
  [113] = 1081,
  [119] = 1094,
  [101] = 1091,
  [114] = 1082,
  [116] = 1077,
  [121] = 1085,
  [117] = 1075,
  [105] = 1096,
  [111] = 1097,
  [112] = 1079,
  [91] =  1093,
  [93] =  1098,

  [97] =  1092,
  [115] = 1099,
  [100] = 1074,
  [102] = 1072,
  [103] = 1087,
  [104] = 1088,
  [106] = 1086,
  [107] = 1083,
  [108] = 1076,
  [59] =  1078,
  [39] =  1101,

  [122] = 1103,
  [120] = 1095,
  [99] =  1089,
  [118] = 1084,
  [98] =  1080,
  [110] = 1090,
  [109] = 1100,
  [44] =  1073,
  [46] =  1102,

  -- CAPS EN-RU
  [81] = 1049,
  [87] = 1062,
  [69] = 1059,
  [82] = 1050,
  [84] = 1045,
  [89] = 1053,
  [85] = 1043,
  [73] = 1064,
  [79] = 1065,
  [80] = 1047,
  [123] = 1061,
  [125] = 1066,

  [65] = 1060,
  [83] = 1067,
  [68] = 1042,
  [70] = 1040,
  [71] = 1055,
  [72] = 1056,
  [74] = 1054,
  [75] = 1051,
  [76] = 1044,
  [58] = 1046,
  [34] = 1069,

  [90] = 1071,
  [88] = 1063,
  [67] = 1057,
  [86] = 1052,
  [66] = 1048,
  [78] = 1058,
  [77] = 1068,
  [60] = 1041,
  [62] = 1070,

  -- ru-en
  [1081] = 113,
  [1094] = 119,
  [1091] = 101,
  [1082] = 114,
  [1077] = 116,
  [1085] = 121,
  [1075] = 117,
  [1096] = 105,
  [1097] = 111,
  [1079] = 112,
  [1093] = 91,
  [1098] = 93,

  [1092] = 97,
  [1099] = 115,
  [1074] = 100,
  [1072] = 102,
  [1087] = 103,
  [1088] = 104,
  [1086] = 106,
  [1083] = 107,
  [1076] = 108,
  [1078] = 59,
  [1101] = 39,

  [1103] = 122,
  [1095] = 120,
  [1089] = 99,
  [1084] = 118,
  [1080] = 98,
  [1090] = 110,
  [1100] = 109,
  [1073] = 44,
  [1102] = 46,

  -- CAPS RU-EN
  [1049] = 81,
  [1062] = 87,
  [1059] = 69,
  [1050] = 82,
  [1045] = 84,
  [1053] = 89,
  [1043] = 85,
  [1064] = 73,
  [1065] = 79,
  [1047] = 80,
  [1061] = 123,
  [1066] = 125,

  [1060] = 65,
  [1067] = 83,
  [1042] = 68,
  [1040] = 70,
  [1055] = 71,
  [1056] = 72,
  [1054] = 74,
  [1051] = 75,
  [1044] = 76,
  [1046] = 58,
  [1069] = 34,

  [1071] = 90,
  [1063] = 88,
  [1057] = 67,
  [1052] = 86,
  [1048] = 66,
  [1058] = 78,
  [1068] = 77,
  [1041] = 60,
  [1070] = 62,
}

function source.new()
    return setmetatable({}, { __index = source })
end

function source:is_available()
  return true
end

function source:get_keyword_pattern()
  return [[\S\+]]
end

local function transform(text)
  local res = ""
  for pos, codepoint in utf.next, text do
    local code
    if not keys[codepoint] then code = codepoint else code = keys[codepoint] end
    res = utf.insert(res, utf.char(code))
  end
  print(res)
  if text == res then
    return nil
  else
    return res
  end
end

function source:complete(request, callback)
  local input = string.sub(request.context.cursor_before_line, request.offset -1)
  local items = {}
  local t = transform(input)
  table.insert(items, {
    filterText = input,
    label = t,
    insertText = t,
    textEdit = {
      newText = t,
      range = {
        start = {
          line = request.context.cursor.row - 1,
          character = request.context.cursor.col - 1 - #input,
        },
        ['end'] = {
          line = request.context.cursor.row - 1,
          character = request.context.cursor.col - 1,
        },
      },
    },
  })
  callback({
    items = items,
    isIncomplete = true
  })
end

return source

