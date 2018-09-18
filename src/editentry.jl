function Add_comment()
    i=0

    println("UUID:")
    uuid = replace(readline(),'/','-')
    filepath = search_uuid(pwd(),uuid[1:8])
    println("-----------------------------------------------------------------------------------------------------")

    main_dir = pwd()
    start = search(filepath,uuid[1:8])[1]
    lbl = filepath[start+8:end-5]
    cat = open(filepath)
    cat_dict = JSON.parse(cat)

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
           println(sub_dict)
        println(lbl)
        if !haskey(cat_dict[lbl],sub_dict)
            println("Err")
        end
                if haskey(cat_dict[lbl],sub_dict)
                      #sub_dict = cat_dict[lbl][sub_dict]
                      println("Please type the comment you want to add to " * sub_dict * ":")
                      add_comment = readline() #insert comment you want to be added to the array
                      println("-----------------------------------------------------------------------------------------------------")
                      push!(cat_dict[lbl][sub_dict], add_comment) #append new comment to array
                          open(filepath, "w") do f
                          JSON.print(f, cat_dict)#overwrite old file with new one
                          end
                elseif !haskey(cat_dict[lbl],sub_dict)
                      step = choice_array[answer][3:end-9]
                      println(step)
                      sub_dict = choice_array[answer][3:end]
                      println("Please type the comment you want to add to " * sub_dict * ":")
                      add_comment = readline() #insert comment you want to be added to the array
                      push!(cat_dict[lbl][step][sub_dict], add_comment) #append new comment to array
                            open(filepath, "w") do f
                            JSON.print(f, cat_dict)#overwrite old file with new one
                            end
        end
    end
end

export Add_comment

function Add_measurement()

    println("UUID:")
    uuid = replace(readline(),'/','-')
    filepath = search_uuid(pwd(),uuid[1:8])

    ###Search() comes above it###
    println("-----------------------------------------------------------------------------------------------------")

    main_dir = pwd()
    start = search(filepath,uuid[1:8])[1]
    lbl = filepath[start+8:end-5]

    println(lbl)

  #  cd(filepath)                         #go to where the file is and open it
    cat = open(filepath)                 #open file
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

    open(filepath, "w") do f
      JSON.print(f, cat_dict)   #overwrite old file with new file
    end
end

export Add_measurement
