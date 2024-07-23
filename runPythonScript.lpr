program runPythonScript;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1,
  SysUtils, ShellApi;

{$R *.res}

var
  theScript: string;
  params: string;
  ext: string;
  i: integer;
  status: integer;
begin
  Application.Title:='runPythonScriptFromVisio';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);

  if ParamCount > 4 then
  begin
    // get the script name
    theScript := ParamStr(5);
    // replace any %20 in script name with space
    theScript := StringReplace(theScript, '%20', ' ', [rfReplaceAll]);

    // get any parameters
    params := '';
    //Form1.Memo1.Lines.Add('Param count = ' + IntToStr(ParamCount));
    if ParamCount > 5 then
    begin
      for i := 6 to ParamCount do
      begin
        params := params + ParamStr(i) + ' ';
      end;
    end;
    // replace any %20 in param with space
    if params <> '' then
      theScript := StringReplace(params, '%20', ' ', [rfReplaceAll]);

    // output them for debugging
    //Form1.Memo1.Lines.Add(theScript);
    //Form1.Memo1.lines.Add(params);
    // get the script extension
    ext := ExtractFileExt(theScript);
    // only work with python extensions
    if (ext = '.py') or (ext = '.py3') or (ext = '.pyc') or (ext = '.pyw') then
    begin
      //Form1.Memo1.lines.Add('Found Python file');
      // run the script
      status :=  ShellExecute(0,'open',PChar(theScript),PChar(params),PChar(ExtractFilePath(theScript)),0);
      // check for success
      if status > 32 then
      begin
        //success
        Form1.Memo1.lines.Add('Run Python Scripts in Visio V1.1');
      end
      else
      begin
        // return values 0..32 are errors
        Form1.Memo1.lines.Add('Error ' + IntToStr(status));
      end;
    end;
  end;

  Application.Run;
end.

