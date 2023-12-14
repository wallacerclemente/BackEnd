program BackEnd;

{$APPTYPE CONSOLE}

{$R *.res}

uses Horse, System.JSON, Horse.Jhonson, Horse.Commons, System.SysUtils;

var
  Users : TJSONArray;

begin

  THorse.Use(Jhonson());

  Users := TJSONArray.Create;

  THorse.Get('/users',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send<TJSONAncestor>(Users.Clone);
    end);

  THorse.Post('/users',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      User : TJSONObject;
    begin
      User :=  Req.Body<TJSONObject>.Clone as TJSONObject ;
      users.AddElement(User);
      Res.Send<TJSONAncestor>(User.Clone).Status(THTTPStatus.Created);
    end);

  THorse.Delete('/users/:id',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      id : Integer;
    begin
      id:= Req.Params.Items['id'].ToInteger;
       Users.Remove(Pred(id)).Free;
      Res.Send<TJSONAncestor>(Users.Clone).Status(THTTPStatus.NoContent);
    end);

  THorse.Listen(9000);
  Users.Destroy;
end.
