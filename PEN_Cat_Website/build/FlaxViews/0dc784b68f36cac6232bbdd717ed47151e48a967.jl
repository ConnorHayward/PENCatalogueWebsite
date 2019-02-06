# C:\Users\ill_f\Documents\GitHub\PEN-Genie\PEN_Cat_Website\app\resources\books\views\billgatesbooks.jl.html 

function func_0dc784b68f36cac6232bbdd717ed47151e48a967() 
Flax.skip_element() do;[
	Flax.skip_element() 
	Flax.skip_element() do;[
				Flax.h1() do;[
			"Bill Gates' top $( length(@vars(:books)) ) recommended books"
		]end

		Flax.ul() do;[
			
      @foreach(@vars(:books)) do book
         "<li>$(book.title) by $(book.author)"
      end
   

		]end

		Flax.a(href = "localhost:8000/home" ) do;[
			"Home2"
		]end

	]end

]end
end 
