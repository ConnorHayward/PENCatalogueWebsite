function search_uuid(catalogue_dir::String, uuid::String; levels::Int=10)
    i = 0
    while true
        temp = glob(uuid*"*",catalogue_dir)
        if length(temp) == 0
            uuid = "*/"*uuid
        end
        if length(temp) != 0
            return temp[1]
        end
        i += 1
        if i == levels
            println("could not be found")
        end
    end
end

export search_uuid

function read_entry(uuid::String)

    filepath = search_uuid(pwd(),uuid)
    cat = open(filepath)
    cat_dict = JSON.parse(cat)

    array = collect(keys(cat_dict))[1]
    for i in eachindex(array)
        if typeof(cat_dict[array[i]]) == Dict{String,Any}
            for key in keys(array[i])
                if typeof(array[i][key])==Dict{String,Any}
                    for key2 in keys(array[i][key])
                        println(key2*": ", array[i][key][key2])
                    end
                else
                    println(key*": ", array[i][key])
                end
            end
        else
            println(array[i]": ",cat_dict[array[i]])
        end
    end
end

export read_entry
#################################################################################
###Felixs input function, used instead of readline()###
#################################################################################

function input(prompt::String=""; add_strings=[] , format="String")::String
           println(prompt)
    if length(add_strings) > 0
        i = 1
        while i <= length(add_strings)
            println(add_strings[i])
            i += 1
        end
    end

    format = lowercase(format)
    if format == "string"
           return chomp(readline())
    elseif format == "integer"
        format = "int"
    elseif format == "int64"
        format = "int"
    elseif format == "int"

    elseif format == "float64"
        format = "float"
    elseif format == "float"

    else
        return "format is not known, please use integer, float or string"
    end
    if format == "int"
        bool = false
        while bool == false
            temp = readline()
            if typeof(try Int(float(temp)) end) == Int64
                bool = true
                return temp
            else
                println("Please enter an integer.")
            end
        end
    elseif format == "float"
        bool = false
        while bool == false
            temp = readline()
            if typeof(try float(temp) end) == Float64
                bool = true
                return temp
            else
                println("Please enter a number.")
            end
        end
    end
#Example
#-------------------------------------------------------------------------
#input("How old are you?"; add_strings=["If you want to add extra information" "add some lines here" "in this array"], format="Int")
#-------------------------------------------------------------------------
end

export input
