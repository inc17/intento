function plan = buildfile

% Agregar la carpeta de origen al path
addpath("simu");

% Crear un plan
plan = buildplan(@buildTasks);

% Agregar una tarea para ejecutar las pruebas
plan("test") = matlab.buildtool.tasks.TestTask(buildTasks);

% Establecer la tarea "test" como la tarea predeterminada en el plan
plan.DefaultTasks = "test";

end

function tasks = buildTasks()
% Esta función devuelve las tareas que se deben incluir en el plan de construcción

% Agregar aquí todas las tareas que necesites
tasks = ["test"]; % Puedes agregar más tareas aquí si es necesario

end
