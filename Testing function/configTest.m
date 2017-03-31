
ini = IniConfig();

ini.ReadFile('example.ini')

sections = ini.GetSections()

tmp=sections(2)

tmp{1}
class(tmp)

[keys, count_keys] = ini.GetKeys(sections{2})
values = ini.GetValues(sections{2}, keys)

class(values)