program sudoku;

uses
  Crt;

const
  BOARD_SIZE = 9;
  BOX_SIZE = 3;

type
  SudokuBoard = array[1..BOARD_SIZE, 1..BOARD_SIZE] of Integer;

var
  OriginalBoard: SudokuBoard;
  UserBoard: SudokuBoard;

{ Función para verificar si un número es válido en una posición específica }
function IsValidNumber(board: SudokuBoard; row, col, num: Integer): Boolean;

var
  i, j, boxRow, boxCol: Integer;
begin
  { Verificar si el número ya existe en la fila o columna }
  for i := 1 to BOARD_SIZE do
  begin
    if (board[row, i] = num) or (board[i, col] = num) then
    begin
      IsValidNumber := False;
      Exit;
    end;
  end;

  { Verificar si el número ya existe en el cuadrante 3x3 }
  boxRow := (row - 1) div BOX_SIZE;
  boxCol := (col - 1) div BOX_SIZE;

  for i := 1 to BOX_SIZE do
  begin
    for j := 1 to BOX_SIZE do
    begin
      if board[boxRow * BOX_SIZE + i, boxCol * BOX_SIZE + j] = num then
      begin
        IsValidNumber := False;
        Exit;
      end;
    end;
  end;

  IsValidNumber := True;
end;

{ Procedimiento para cargar el tablero inicial con pistas }
procedure LoadBoard(var board: SudokuBoard);
begin
  { Aquí se debe implementar la lógica para cargar el tablero inicial
    con al menos 17 pistas. Puedes generar aleatoriamente las pistas
    o definirlas manualmente. Asegúrate de que el tablero inicial
    tenga una solución única. }
end;

{ Procedimiento para mostrar el tablero en la pantalla }
procedure DisplayBoard(board: SudokuBoard);
var
  i, j: Integer;
begin
  ClrScr;

  for i := 1 to BOARD_SIZE do
  begin
    for j := 1 to BOARD_SIZE do
    begin
      { Resaltar las pistas con un color diferente }
      if OriginalBoard[i, j] <> 0 then
        TextColor(Yellow)
      else
        TextColor(White);

      write(board[i, j], ' ');

      { Restaurar el color predeterminado para las celdas regulares }
      if (j mod BOX_SIZE = 0) and (j < BOARD_SIZE) then
        TextColor(White);
    end;

    writeln;

    { Restaurar el color predeterminado para las filas de cuadrantes }
    if (i mod BOX_SIZE = 0) and (i < BOARD_SIZE) then
      TextColor(White);
  end;

  TextColor(White);
end;

{ Función para verificar si el tablero se ha completado correctamente }
function IsBoardComplete(board: SudokuBoard): Boolean;
var
  i, j: Integer;
begin
  for i := 1 to BOARD_SIZE do
  begin
    for j := 1 to BOARD_SIZE do
    begin
      { Si hay alguna celda vacía, el tablero no está completo }
     

 if board[i, j] = 0 then
      begin
        IsBoardComplete := False;
        Exit;
      end;
    end;
  end;

  IsBoardComplete := True;
end;

{ Procedimiento para solicitar al usuario las filas y columnas para ingresar un número }
procedure GetUserInput(var row, col, num: Integer);
begin
  writeln('Ingrese las coordenadas de la celda (fila, columna) donde desea colocar un numero:');
  write('Fila: ');
  readln(row);
  write('Columna: ');
  readln(col);
  write('Numero: ');
  readln(num);
end;

{ Procedimiento para validar y actualizar el tablero con la entrada del usuario }
procedure UpdateBoard(var board: SudokuBoard; row, col, num: Integer);
begin
  if IsValidNumber(board, row, col, num) then
    board[row, col] := num
  else
    writeln('¡Numero no válido! Inténtelo de nuevo.');
end;

{ Procedimiento para verificar si el juego ha terminado y mostrar el mensaje correspondiente }
procedure CheckGameStatus(board: SudokuBoard);
begin
  if IsBoardComplete(board) then
  begin
    writeln('¡Felicidades! Has completado el Sudoku correctamente.');
    writeln('Presiona cualquier tecla para salir.');
    ReadKey;
    Halt;
  end;
end;

{ Procedimiento principal del juego }
procedure PlaySudoku;
var
  row, col, num: Integer;
begin
  LoadBoard(OriginalBoard);
  UserBoard := OriginalBoard;

  repeat
    DisplayBoard(UserBoard);
    GetUserInput(row, col, num);
    UpdateBoard(UserBoard, row, col, num);
    CheckGameStatus(UserBoard);
  until False; { El juego solo se cierra si el usuario lo cancela manualmente }
end;

begin
  PlaySudoku;
end.
