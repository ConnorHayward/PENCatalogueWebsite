module PENCatalogueManager

###Creating files for batches and tiles####
using FileIO
using JSON

# Default method to add a structure of type sample to the cataloge


function maketile()

    cat = open("tile.json")
    cat_dict = JSON.parse(cat)

    print("Type:")
    bt = readline()
    #bt = lowercase(bt)

    #print("Batch Number")
    #bn = readline()

    print("Producer:")
    prod = readline()
    #prod = lowercase(prod)

    print("Material:")
    gt = readline()

    print("Run Reference:")
    rr = readline()

    println("General Comments")
    gen_com = []

    println("Properties")
    print("Geometry:")
    geo = readline()
    geo = lowercase(geo)
    print("Size:")
    sz = readline()


    print("Tile Number:")
    tn = readline()

    print("Properties Comments:")
    prop_com = []

    lbl = "$bt-$gt-$prod-$rr-$tn"
    uuid = ""
    uuid = string(Base.Random.uuid4())

    dict = Dict("Batch Type"=>bt, "label"=>lbl,"Run Reference"=>rr,"General Comments"=>gen_com,"UUID"=>uuid, "Tile Number"=>tn,

            "Properties"=>Dict("Geometry"=>geo,"Size"=>sz,"material"=>gt,
                "date"=>"","process"=>"","Properties Comments"=>prop_com),

            "Measurements"=>Dict("wavelength"=> Dict()
            , "peak wavelength"=> Dict()
            , "light output"=> Dict()
            , "absorbed at 430nm"=>Dict()))

    target_dir = "catalogue/$bt/$gt/$prod/$rr/Tiles/$tn"


    if haskey(cat_dict,lbl)
       println("Already Exists")
        return
    end





    if !isdir(target_dir)
        mkpath(target_dir)
    end


    cat_dict[lbl]=dict

    export_dict = Dict(lbl=>dict)

    filename = target_dir*"/"*uuid[1:8]*lbl*".json"
    stringdata = JSON.json(cat_dict)
    open("tile.json","w") do f
        write(f, stringdata)
    end
    stringdata = JSON.json(export_dict)
    open(filename, "w") do f
        write(f, stringdata)
    end


end
export maketile

function makebatch()

    cat = open("demo.json")
    cat_dict = JSON.parse(cat)

    lbl = ""
    uuid = ""
    typ = "Batch"
    dict = Dict()

    print("Batch Type:")
    bt = readline()
    bt = lowercase(bt)

    if bt == "granulate"
        bt = "Granulate"
        print("Granulate Type:")
        gt = readline()
        print("Manufacturer:")
        man=readline()
        manlbl = lowercase(man[1:3])
        print("Batch Number:")
        bn = readline()
        lbl = "gran-$manlbl-$gt-$bn"
        uuid = string(Base.Random.uuid4())
        dict = Dict("Type"=>typ,"Product"=>bt,"label"=>lbl,"UUID"=>uuid,"Product"=>gt,"Manufacturer"=>man,"Batch Number"=>bn)
        target_dir = "catalogue/$typ/$bt/$gt/$bn/"

    elseif bt == "raw pen"
        bt = "rawpen"
        print("Mass:")
        m = readline()
        print("Creation Date:")
        date = readline()
        print("Manufacturer:")
        man = readline()
        print("Batch Number")
        bn = readline()
        lbl = lowercase(bt)*"-$man-$bn"
        uuid = string(Base.Random.uuid4())
        dict = Dict("Type"=>typ,"Product"=>bt,"label"=>lbl, "UUID"=>uuid,"mass"=>m,
                "Creation"=>Dict("date"=>date,"manufacturer"=>man))
        target_dir = "catalogue/$typ/$bt/$gt/$bn/"

    elseif bt == "tile"
        bt = "Tile"
        print("Manufacturer")
        man = readline()
        print("Run Reference:")
        rr = readline()
        bn = rr
        print("Creation Date:")
        date = readline()
        print("Process:")
        pr = readline()
        print("Material:")
        gt = readline()
        uuid = string(Base.Random.uuid4())
        lbl = "$bt-$gt-$man-$rr"

        print("Predrying Temp:")
        pdt = readline()
        print("Predrying Time:")
        pdtime = readline()
        print("Humidity:")
        hum = readline()
        print("Clamping Force")
        force = readline()

        println("Heating Profile")
        print("Inlet:")
        itemp = readline()
        print("Zone4:")
        z4 = readline()
        print("Zone3:")
        z3 = readline()
        print("Zone2:")
        z2 = readline()
        print("Zone1:")
        z1 = readline()
        print("Nozzle")
        nz = readline()

        print("Mold Temperature: ")
        mt_set = readline()
        print("Mold Temp (ejector):")
        mt_ej = readline()
        print("Mold Temp (nozzle):")
        mt_nz = readline()
        temp_dict = Dict("Mold Temp"=>mt_set, "Mold Temp (ejector)"=>mt_ej, "Mold Temp (nozzle)"=>mt_nz)

        print("Torque Dosing:")
        td = readline()
        print("Dosing Volume:")
        dv = readline()
        print("Circumferential Speed:")
        cs = readline()
        print("Back Pressure:")
        bp = readline()
        print("Cooling Time:")
        ct = readline()

        print("Water Cooling")
        wc = readline()
        print("Injection Pressure:")
        ip = readline()
        print("Injection Speed:")
        is = readline()
        print("Injection Time:")
        it = readline()
        inj_dict = Dict("Injection Speed"=>is,"Injection Time"=>it,"Injection Pressure"=>ip)

        print("Switchover Point:")
        sp = readline()
        print("Holding Pressure:")
        hp = readline()
        print("Holding Pressure Time:")
        hpt = readline()
        print("Holding Pressure Speed:")
        hps = readline()
        print("Melt Cushion: ")
        mc = readline()

        print("Comments:")
        com = []

        dict = Dict("Type"=>typ, "Product"=>bt, "label"=>lbl,"Run Reference"=>rr,"UUID"=>uuid,
            "Creation"=>Dict("date"=>date,"manufacturer"=>man,"process"=>pr,"material"=>gt,
                "Drying Temp"=>pdt,"Drying Time"=>pdtime, "Humidity"=>hum, "Clamping Force"=>force,
                "Temp Profile"=>Dict("Inlet [C]"=>itemp,"Zone4 []"=>z4,"Zone3"=>z3,"Zone2"=>z2,"Zone1"=>z1,"Nozzle"=>nz),
                "Mold Temps"=>Dict("Mold Temp [C]"=>mt_set, "Mold Temp (ejector) [C]"=>mt_ej, "Mold Temp (nozzle) [C]"=>mt_nz),
                "Injection Paramaters"=>Dict("Injection Speed [cm^3/s]"=>is,"Injection Time [s]"=>it,"Injection Pressure [bar]"=>ip),
                "Torque Dosing [Nm]"=> td, "Dosing Volume [cm^3]"=>dv,"Circumferential Speed [m/min]"=>cs,"Back Pressure [bar]"=>bp,"Cooling Time [s]"=>ct,
                "Switchover Point [cm^3]"=>sp,"Holding Pressure [bar]"=>hp,"Holding Pressure Time [s]"=>hpt,"Holding Pressure Speed [cm^3/s]"=>hps,
                "Melt Cushion [cm^3]"=>mc,"Comments"=>com))
        target_dir = "catalogue/$typ/$bt/$gt/$man/$bn/"
    end

    if haskey(cat_dict,lbl)
       println("Already Exists")
        return
    end



    if !isdir(target_dir)
        mkpath(target_dir)
    end

    cat_dict[lbl]=dict

    export_dict = Dict(lbl=>dict)

    filename = target_dir*uuid[1:8]*lbl*".json"
    stringdata = JSON.json(cat_dict)
    open("demo.json","w") do f
        write(f, stringdata)
    end
    stringdata = JSON.json(export_dict)
    open(filename, "w") do f
        write(f, stringdata)
    end


end

export makebatch
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
#################################################################################
###searching for a certain batch or tile###
#################################################################################

using Glob
function search()
    println("Which of these folders do you want to search in:")
    path = "/home/iwsatlas1/pappas/Documents/catalogue/"
    #key = "*/*/*/*/*/*"*".json"
    #glob("*", path)
    a = glob("*/", path)
    #println(a[1])
    x = a[1][(length(a[1])-4):end]
    #println(x)

    #while x != ".json"
    glob_array = [1]
    oldfilepath = ""
    while path[end-5:end]!=".json/"

        glob_array = glob("*", path)
    #    println(glob_array)
        i=1

        if length(glob_array)==0
            glob_array = glob("*.json",path)
        end

        while i <= length(glob_array)
            glob_array[i] = "$i-"*glob_array[i][(length(path)+1):end]
            println(glob_array[i])
            i +=1
        end

        answer = Int(float(input("Please type one of the numbers above:"; format="int")))
        if answer > length(glob_array)
            println("Wrong Entry")
        elseif answer == Int(float(glob_array[answer][1:1]))
            oldfilepath = path
            path = (path*glob_array[answer][3:end]*"/")
            #println(path1)
        end
    #println(path[end-5:end])
    end
    #glob_array = glob("*", path)
    #println(glob_array)
    println(path)

end
export search
#################################################################################
###Add a comment, general or properties to the dictionary###
#################################################################################

function addcomment()
    ###Search comes above it###
    println("-----------------------------------------------------------------------------------------------------")
    filename = path[length(oldfilepath)+1:end-1] #use oldfile/path from before to create sensible names
    filepath = oldfilepath
    cd(filepath)#go to where the file is and open it
    cat = open(filename)
    cat_dict = JSON.parse(cat)

    lbl = filename[9:end-5]
    println(lbl)
    println("-----------------------------------------------------------------------------------------------------")

    i = 1
    choice_array = ["1-General Comments", "2-Properties Comments"]
    println("You can add following comments")
    println("-----------------------------------------------------------------------------------------------------")
    while i <= length(choice_array)
        println(choice_array[i])
        i += 1
    end
    println("-----------------------------------------------------------------------------------------------------")

    answer = Int(float(input("Please type one of the numbers above:"; format="int")))

    if answer > length(choice_array)       #return a readline() in case something wrong was entered
        bool = false
        while bool == false
            temp1 = Int(float(input("Please enter only one of the numbers displayed"; format="int")))
            if temp1 <= length(choice_array)
                bool = true
                return temp1
            #else
            #   print("Please enter only one of the numbers displayed")
            end
        end

    elseif answer == Int(float(choice_array[answer][1:1]))   #since general comments and properties comments are in diffent
            sub_dict = choice_array[answer][3:end]               #subdictionaries here is a way to distinguish them
                if haskey(cat_dict[lbl],sub_dict)
                      #sub_dict = cat_dict[lbl][sub_dict]
                      println("Please type the comment you want to add to " * sub_dict * ":")
                      add_comment = readline() #insert comment you want to be added to the array
                      println("-----------------------------------------------------------------------------------------------------")
                      push!(cat_dict[lbl][sub_dict], add_comment) #append new comment to array
                          open(filename, "w") do f
                          JSON.print(f, cat_dict)#overwrite old file with new one
                          end
                elseif !haskey(cat_dict[lbl],sub_dict)
                      step = choice_array[answer][3:end-9]
                      println(step)
                      sub_dict = choice_array[answer][3:end]
                      println("Please type the comment you want to add to " * sub_dict * ":")
                      add_comment = readline() #insert comment you want to be added to the array
                      push!(cat_dict[lbl][step][sub_dict], add_comment) #append new comment to array
                            open(filename, "w") do f
                            JSON.print(f, cat_dict)#overwrite old file with new one
                            end
        end
    end
end

export addcomment
#################################################################################
###Add measurements to the dictionary###
#################################################################################

function addmeasurement()
###Search() comes above it###
println("-----------------------------------------------------------------------------------------------------")
filename = path[length(oldfilepath)+1:end-1] #use oldfile/path from before to create sensible names
filepath = oldfilepath
lbl = filename[9:end-5]

cd(filepath)                         #go to where the file is and open it
cat = open(filename)                 #open file
cat_dict = JSON.parse(cat)
key_array = []
i = 1
k1 = keys(cat_dict[lbl]["Measurements"])    #show subdictionaries
key_array = collect(k1)                     #make list of keys into array

while i <= length(key_array)               #print a list of subdictionaries to choose from
    key_array[i] = "$i-"*key_array[i]
    println(key_array[i])
    i += 1
end
println("-----------------------------------------------------------------------------------------------------")
println("Where do you want to add a measurement?") #choose subdictionary to add key-value pairs to
choose_measurement = Int(float(input("Please type one of the numbers above:"; format="int")))
      if choose_measurement > length(key_array)          #making sure only the displayd proposition can be chosen
            println("Wrong Entry")
      elseif choose_measurement == Int(float(key_array[choose_measurement][1:1]))
            sub_dict = key_array[choose_measurement][3:end]             #access sub-dictionary
            sub_dict = cat_dict[lbl]["Measurements"][sub_dict]
      end
println("-----------------------------------------------------------------------------------------------------")

println("Which Date was the Measurement conducted?")
add_key = readline() #insert key to be added, here most probably the date
println("What was the result?")
add_value = readline() #insert the value you want your key to have
sub_dict[add_key] = add_value #asign key to value
println("-----------------------------------------------------------------------------------------------------")
      open(filename, "w") do f
      JSON.print(f, cat_dict)   #overwrite old file with new file
      end
end
export addmeasurement
#################################################################################
