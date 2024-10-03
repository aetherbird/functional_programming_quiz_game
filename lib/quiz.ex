defmodule FunctionalQuizGame.QuizGame do
  def start do
    number_questions_in_quiz = 20
    questions = load_questions()
    selected_questions = Enum.shuffle(questions) |> Enum.take(number_questions_in_quiz)

    IO.puts("The Elixir Functional Programming Quiz:")
    IO.puts("Your score will be calculated based on your responses to #{number_questions_in_quiz} questions.\n")
    IO.puts("Good luck.\n\n")

    {score, _} = Enum.reduce(selected_questions, {0, 1}, fn question, {acc, num} ->
      IO.puts("Question #{num}:")
      result = ask_question(question)
      new_acc = if result, do: acc + 1, else: acc
      {new_acc, num + 1}
    end)

    IO.puts("\nYou have completed the quiz.")
    IO.puts("FINAL SCORE: #{score}/#{number_questions_in_quiz}")
    percentage = Float.round((score / number_questions_in_quiz) * 100, 2)
    IO.puts("That's #{percentage}% correct.")
    provide_feedback(percentage)
  end

  defp load_questions do
    [
      %{
        type: :tf,
        question: "In Elixir, the pipe operator |> passes the result of the left expression as the first argument to the function on the right.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which OTP behavior is typically used to implement a server that maintains state?",
        options: ["GenServer", "Supervisor", "Application", "Agent"],
        answer: "GenServer"
      },
      %{
        type: :tf,
        question: "Elixir's `Enum.map/2` function is eager, meaning it processes the entire collection immediately.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which function is used to define a module attribute in Elixir?",
        options: ["@attribute", "@def", "@moduledoc", "@doc"],
        answer: "@attribute"
      },
      %{
        type: :tf,
        question: "In Elixir, the `@moduledoc` attribute is used to document individual functions.",
        answer: false
      },
      %{
        type: :mc,
        question: "Which of the following is a correct way to define a documentation for a module in Elixir?",
        options: [
          "@doc \"Module documentation\"",
          "@moduledoc \"Module documentation\"",
          "defmoduledoc \"Module documentation\"",
          "documentation \"Module documentation\""
        ],
        answer: "@moduledoc \"Module documentation\""
      },
      %{
        type: :tf,
        question: "The `use` macro in Elixir allows a module to inject code into another module.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following keywords is used to import functions from another module in Elixir?",
        options: ["import", "use", "alias", "require"],
        answer: "import"
      },
      %{
        type: :tf,
        question: "Elixir's `require` keyword is used to make macros available in the current module.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which function can be used to fetch a value from a keyword list with a default if the key is not present?",
        options: ["Keyword.get/3", "Keyword.fetch/2", "Keyword.find/2", "Keyword.lookup/2"],
        answer: "Keyword.get/3"
      },
      %{
        type: :tf,
        question: "In Elixir, the `@spec` attribute is used to define type specifications for functions.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following best describes pattern matching in Elixir?",
        options: [
          "A way to perform arithmetic operations",
          "A method to handle exceptions",
          "A mechanism to destructure data",
          "A technique for concurrency"
        ],
        answer: "A mechanism to destructure data"
      },
      %{
        type: :tf,
        question: "Elixir supports default arguments in function definitions.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which keyword is used to define a guard clause in an Elixir function?",
        options: ["when", "if", "unless", "case"],
        answer: "when"
      },
      %{
        type: :tf,
        question: "In Elixir, anonymous functions cannot capture variables from their surrounding context.",
        answer: false
      },
      %{
        type: :mc,
        question: "Which of the following is NOT a valid way to create a list in Elixir?",
        options: ["[1, 2, 3]", "List.new([1, 2, 3])", "{1, 2, 3}", "for x <- 1..3, do: x"],
        answer: "{1, 2, 3}"
      },
      %{
        type: :tf,
        question: "Elixir's `Map` and `Keyword` lists are both ordered collections.",
        answer: false
      },
      %{
        type: :mc,
        question: "Which function is used to merge two maps in Elixir, with values from the second map overwriting the first?",
        options: ["Map.merge/2", "Map.combine/2", "Map.append/2", "Map.union/2"],
        answer: "Map.merge/2"
      },
      %{
        type: :tf,
        question: "In Elixir, atoms are stored as integers under the hood.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is a common use case for the `Agent` module in Elixir?",
        options: [
          "Handling HTTP requests",
          "Managing shared state",
          "Parsing JSON data",
          "Compiling code dynamically"
        ],
        answer: "Managing shared state"
      },
      %{
        type: :tf,
        question: "Elixir's `spawn/1` function is used to create a new lightweight process.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following functions can be used to send a message to a process in Elixir?",
        options: [":send", "send/2", "message/2", "deliver/2"],
        answer: "send/2"
      },
      %{
        type: :tf,
        question: "The `receive` block in Elixir is used to handle incoming messages in a process.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is NOT a valid Elixir data type?",
        options: ["Atom", "Float", "Binary", "Vector"],
        answer: "Vector"
      },
      %{
        type: :tf,
        question: "Elixir's `Struct` enforces a predefined set of keys and default values.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is the correct syntax to define a module in Elixir?",
        options: [
          "module MyModule do ... end",
          "defmodule MyModule do ... end",
          "define MyModule do ... end",
          "module def MyModule do ... end"
        ],
        answer: "defmodule MyModule do ... end"
      },
      %{
        type: :tf,
        question: "In Elixir, modules can contain both functions and macros.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which function is used to pause the execution of the current process for a specified amount of time in Elixir?",
        options: ["Process.sleep/1", "Process.pause/1", "Task.delay/1", "IO.sleep/1"],
        answer: "Process.sleep/1"
      },
      %{
        type: :tf,
        question: "Elixir does not support operator overloading.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following functions converts a list of characters to a string in Elixir?",
        options: ["List.to_string/1", "String.from_charlist/1", "Enum.join/1", "Both A and B"],
        answer: "Both A and B"
      },
      %{
        type: :tf,
        question: "Elixir's `@behaviour` attribute is used to implement interfaces defined by other modules.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which Elixir function can be used to retrieve the current process's PID?",
        options: ["self()", "pid()", "current_process()", "Process.id()"],
        answer: "self()"
      },
      %{
        type: :tf,
        question: "Elixir allows multiple function clauses with different patterns for the same function name.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which keyword is used to define a module's documentation in Elixir?",
        options: ["@doc", "@documentation", "@moduledoc", "@info"],
        answer: "@moduledoc"
      },
      %{
        type: :tf,
        question: "In Elixir, the `@type` attribute is used to define custom types.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is a common practice for handling configuration in Elixir applications?",
        options: ["Hardcoding values in modules", "Using environment variables", "Storing in external JSON files", "Using Mix configuration"],
        answer: "Using Mix configuration"
      },
      %{
        type: :tf,
        question: "Elixir's `:timer` module provides functions for working with time-related operations.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following best describes immutability in Elixir?",
        options: [
          "Variables can be reassigned new values.",
          "Data structures cannot be altered once created.",
          "Functions can have side effects.",
          "Processes share state by default."
        ],
        answer: "Data structures cannot be altered once created."
      },
      %{
        type: :tf,
        question: "Elixir's `Supervisor` modules can automatically restart child processes if they crash.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is used to define a supervision tree in Elixir?",
        options: ["Supervisor.start_link/2", "GenServer.start_link/2", "Task.start_link/1", "Process.start_link/1"],
        answer: "Supervisor.start_link/2"
      },
      %{
        type: :tf,
        question: "Elixir's `alias` keyword can be used to rename modules for easier reference.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which function is used to fetch a value from a map with pattern matching in Elixir?",
        options: ["Map.fetch/2", "Map.get/2", "Map.find/2", "Map.lookup/2"],
        answer: "Map.fetch/2"
      },
      %{
        type: :tf,
        question: "In Elixir, the `defguard` macro is used to define custom guard clauses.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is NOT a valid way to handle errors in Elixir?",
        options: [
          "Using `try/rescue` blocks",
          "Leveraging `with` statements",
          "Ignoring errors and continuing execution",
          "Implementing supervision trees"
        ],
        answer: "Ignoring errors and continuing execution"
      },
      %{
        type: :tf,
        question: "Elixir's `IO.inspect/2` function is commonly used for debugging purposes.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is a correct way to define a function with multiple clauses in Elixir?",
        options: [
          "def func(x) do ... end; def func(y) do ... end",
          "def func(x), do: ...; def func(y), do: ...",
          "Both A and B",
          "Neither A nor B"
        ],
        answer: "Both A and B"
      },
      %{
        type: :tf,
        question: "Elixir's `for` comprehension can be used for both enumeration and side effects.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is the correct way to define a module documentation in Elixir?",
        options: [
          "@moduledoc \"This module does XYZ.\"",
          "@module \"This module does XYZ.\"",
          "defmodule_doc \"This module does XYZ.\"",
          "module_doc \"This module does XYZ.\""
        ],
        answer: "@moduledoc \"This module does XYZ.\""
      },
      %{
        type: :tf,
        question: "In Elixir, the `Kernel` module is automatically imported into every module.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is used to define a custom exception in Elixir?",
        options: [
          "defexception",
          "deferror",
          "exception",
          "defex"
        ],
        answer: "defexception"
      },
      %{
        type: :tf,
        question: "Elixir's `nil` is considered a truthy value in conditional expressions.",
        answer: false
      },
      %{
        type: :mc,
        question: "Which of the following is a way to concatenate two strings in Elixir?",
        options: [
          "String.concat/2",
          "++ operator",
          "Both A and B",
          "Neither A nor B"
        ],
        answer: "String.concat/2"
      },
      %{
        type: :tf,
        question: "In Elixir, `String` and `List` are interchangeable data types.",
        answer: false
      },
      %{
        type: :mc,
        question: "Which Elixir function can be used to convert a string to an atom?",
        options: [
          "String.to_atom/1",
          "Atom.from_string/1",
          "String.atomize/1",
          "Atom.to_string/1"
        ],
        answer: "String.to_atom/1"
      },
      %{
        type: :tf,
        question: "Elixir's `GenServer` abstracts the boilerplate of managing state and handling synchronous and asynchronous calls.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following functions is used to define a function that can be called from other modules in Elixir?",
        options: [
          "def",
          "defp",
          "defmacro",
          "defdelegate"
        ],
        answer: "def"
      },
      %{
        type: :tf,
        question: "Elixir's `Task.async/1` and `Task.await/2` are used for managing asynchronous tasks.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is NOT a valid way to create a tuple in Elixir?",
        options: [
          "{:ok, \"Success\"}",
          "Tuple.new([:ok, \"Success\"])",
          "{:ok, \"Success\",}",
          "[{:ok, \"Success\"}]"
        ],
        answer: "[{:ok, \"Success\"}]"
      },
      %{
        type: :tf,
        question: "In Elixir, the `!` operator is used to indicate that a function may raise an exception.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following functions can be used to list all processes in the current Elixir node?",
        options: [
          "Process.list/0",
          "Process.all/0",
          "Process.get_all/0",
          "Process.show/0"
        ],
        answer: "Process.list/0"
      },
      %{
        type: :tf,
        question: "Elixir allows the use of sigils for working with regular expressions and other literals.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is the correct syntax for a regex in Elixir?",
        options: [
          "~r/regex/",
          "/~r(regex)/",
          "/regex/",
          "regex//"
        ],
        answer: "~r/regex/"
      },
      %{
        type: :tf,
        question: "In Elixir, all functions are public by default unless specified otherwise.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is used to define a function with variable arguments in Elixir?",
        options: [
          "def func(args \\ [])",
          "def func(args...)",
          "def func(*args)",
          "def func(args *)"
        ],
        answer: "def func(args \\ [])"
      },
      %{
        type: :tf,
        question: "Elixir's `Stream` module provides functions that return lazy enumerables.",
        answer: true
      },
      %{
        type: :mc,
        question: "Which of the following is the correct way to pattern match on a map in a function head in Elixir?",
        options: [
          "def func(%{key: value}) do ... end",
          "def func(map = %{key: value}) do ... end",
          "Both A and B",
          "Neither A nor B"
        ],
        answer: "Both A and B"
      },
    ]
  end

  defp ask_question(%{type: :tf, question: q, answer: a}) do
    IO.puts("#{q}")
    IO.puts("1. True")
    IO.puts("2. False")
    user_answer = get_input(["1", "2"])
    
    selected =
      case user_answer do
        "1" -> true
        "2" -> false
      end

    correct = selected == a
    feedback(correct, a)
    correct
  end

  defp ask_question(%{type: :mc, question: q, options: opts, answer: a}) do
    IO.puts(q)
    Enum.each(Enum.with_index(opts, 1), fn {opt, idx} ->
      IO.puts("#{idx}. #{opt}")
    end)
    user_choice = get_input(Enum.map(opts, &Integer.to_string(Enum.find_index(opts, fn x -> x == &1 end) + 1)))
    user_index = String.to_integer(user_choice) - 1
    selected = Enum.at(opts, user_index)
    correct = selected == a
    feedback(correct, a)
    correct
  end

  defp get_input(valid_options) do
    input = IO.gets("> ") |> String.trim() |> String.downcase()
    cond do
      Enum.member?(valid_options, input) -> input
      Enum.any?(valid_options, fn opt ->
        case Integer.parse(opt) do
          {num, ""} -> Integer.to_string(num) == input
          _ -> false
        end
      end) -> input
      true ->
        IO.puts("Invalid input. Please try again.")
        get_input(valid_options)
    end
  end

  # Removed parse_tf as it's no longer needed for tf questions
  # defp parse_tf("true"), do: true
  # defp parse_tf("t"), do: true
  # defp parse_tf("false"), do: false
  # defp parse_tf("f"), do: false

  defp feedback(true, _), do: IO.puts("Correct!\n")
  defp feedback(false, correct_answer), do: IO.puts("Incorrect. The correct answer was: #{correct_answer}\n")

  defp provide_feedback(percentage) when percentage >= 90, do: IO.puts("Excellent work!")
  defp provide_feedback(percentage) when percentage >= 70, do: IO.puts("Good job!")
  defp provide_feedback(percentage) when percentage >= 50, do: IO.puts("Not bad, but there's room for improvement.")
  defp provide_feedback(_), do: IO.puts("Better luck next time!")
end

