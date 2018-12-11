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

function read_entry()

    println("Please Scan Barcode:")
    uuid = uuid = replace(readline(),'/','-')[1:8]
    filepath = search_uuid(pwd(),uuid)
    cat = open(filepath)
    cat_dict = JSON.parse(cat)
println("-----------------------------------------------------------------------------------------------------")
    for key in keys(cat_dict)

        values_dict = cat_dict[key]

        for key1 in keys(values_dict)

            if typeof(values_dict[key1]) != Dict{String,Any} && typeof(values_dict[key1]) != Array{Any,1}
                println(key1*": "*values_dict[key1])
            elseif typeof(values_dict[key1]) == Dict{String,Any}
                for key2 in keys(values_dict[key1])
                    println(key2*": ")
                    if typeof(values_dict[key1][key2])== Dict{String,Any}
                        for key3 in keys(values_dict[key1][key2])
                            println(key3*": "*values_dict[key1][key2][key3])
                        end
                    end

                end
            elseif typeof(values_dict[key1]) == Array{Any,1}
                println("-----------------------------------------------------------------------------------------------------")
                println(key1*": ")
                for value in values(values_dict[key1])
                    println(value)
                end
            end
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
<<<<<<< HEAD
            if typeof(try Int(float(temp))catch end) == Int64
=======
            if typeof(try Int(float(temp)) end) == Int64
>>>>>>> 2f059ee07f42d59ee9590d4bc199aca2affdea86
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
<<<<<<< HEAD
            if typeof(try float(temp) catch end) == Float64
=======
            if typeof(try float(temp) end) == Float64
>>>>>>> 2f059ee07f42d59ee9590d4bc199aca2affdea86
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
