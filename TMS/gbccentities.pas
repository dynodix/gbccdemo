unit gbccentities;

interface

uses
  SysUtils, 
  Generics.Collections, 
  Aurelius.Mapping.Attributes, 
  Aurelius.Types.Blob, 
  Aurelius.Types.DynamicProperties, 
  Aurelius.Types.Nullable, 
  Aurelius.Types.Proxy, 
  Aurelius.Criteria.Dictionary;

type
  Tgames = class;
  Tplayers = class;
  Tplayingames = class;
  TgamesTableDictionary = class;
  TplayersTableDictionary = class;
  TplayingamesTableDictionary = class;
  
  [Entity]
  [Table('games')]
  [Id('Fgameuuid', TIdGenerator.None)]
  Tgames = class
  private
    [Column('gameuuid', [TColumnProp.Required], 50)]
    Fgameuuid: string;
    
    [Column('title', [], 50)]
    Ftitle: Nullable<string>;
    
    [Column('description', [], 250)]
    Fdescription: Nullable<string>;
    
    [Column('image', [TColumnProp.Lazy])]
    Fimage: TBlob;
  public
    property gameuuid: string read Fgameuuid write Fgameuuid;
    property title: Nullable<string> read Ftitle write Ftitle;
    property description: Nullable<string> read Fdescription write Fdescription;
    property image: TBlob read Fimage write Fimage;
  end;
  
  [Entity]
  [Table('players')]
  [Id('Fplayeruuid', TIdGenerator.None)]
  Tplayers = class
  private
    [Column('playeruuid', [TColumnProp.Required], 50)]
    Fplayeruuid: string;
    
    [Column('firstname', [], 80)]
    Ffirstname: Nullable<string>;
    
    [Column('lastname', [], 80)]
    Flastname: Nullable<string>;
    
    [Column('borndate', [])]
    Fborndate: Nullable<TDateTime>;
    
    [Column('documentnr', [], 50)]
    Fdocumentnr: Nullable<string>;
    
    [Column('gdpraccept', [])]
    Fgdpraccept: Nullable<Integer>;
  public
    property playeruuid: string read Fplayeruuid write Fplayeruuid;
    property firstname: Nullable<string> read Ffirstname write Ffirstname;
    property lastname: Nullable<string> read Flastname write Flastname;
    property borndate: Nullable<TDateTime> read Fborndate write Fborndate;
    property documentnr: Nullable<string> read Fdocumentnr write Fdocumentnr;
    property gdpraccept: Nullable<Integer> read Fgdpraccept write Fgdpraccept;
  end;
  
  [Entity]
  [Table('playingames')]
  [Id('Fgameuuid', TIdGenerator.None)]
  [Id('Fplayeruuid', TIdGenerator.None)]
  Tplayingames = class
  private
    [Column('lastplay', [])]
    Flastplay: Nullable<TDateTime>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('gameuuid', [TColumnProp.Required], 'gameuuid')]
    Fgameuuid: Proxy<Tgames>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('playeruuid', [TColumnProp.Required], 'playeruuid')]
    Fplayeruuid: Proxy<Tplayers>;
    function Getgameuuid: Tgames;
    procedure Setgameuuid(const Value: Tgames);
    function Getplayeruuid: Tplayers;
    procedure Setplayeruuid(const Value: Tplayers);
  public
    property lastplay: Nullable<TDateTime> read Flastplay write Flastplay;
    property gameuuid: Tgames read Getgameuuid write Setgameuuid;
    property playeruuid: Tplayers read Getplayeruuid write Setplayeruuid;
  end;
  
  TDicDictionary = class
  private
    Fgames: TgamesTableDictionary;
    Fplayers: TplayersTableDictionary;
    Fplayingames: TplayingamesTableDictionary;
    function Getgames: TgamesTableDictionary;
    function Getplayers: TplayersTableDictionary;
    function Getplayingames: TplayingamesTableDictionary;
  public
    destructor Destroy; override;
    property games: TgamesTableDictionary read Getgames;
    property players: TplayersTableDictionary read Getplayers;
    property playingames: TplayingamesTableDictionary read Getplayingames;
  end;
  
  TgamesTableDictionary = class
  private
    Fgameuuid: TDictionaryAttribute;
    Ftitle: TDictionaryAttribute;
    Fdescription: TDictionaryAttribute;
    Fimage: TDictionaryAttribute;
  public
    constructor Create;
    property gameuuid: TDictionaryAttribute read Fgameuuid;
    property title: TDictionaryAttribute read Ftitle;
    property description: TDictionaryAttribute read Fdescription;
    property image: TDictionaryAttribute read Fimage;
  end;
  
  TplayersTableDictionary = class
  private
    Fplayeruuid: TDictionaryAttribute;
    Ffirstname: TDictionaryAttribute;
    Flastname: TDictionaryAttribute;
    Fborndate: TDictionaryAttribute;
    Fdocumentnr: TDictionaryAttribute;
    Fgdpraccept: TDictionaryAttribute;
  public
    constructor Create;
    property playeruuid: TDictionaryAttribute read Fplayeruuid;
    property firstname: TDictionaryAttribute read Ffirstname;
    property lastname: TDictionaryAttribute read Flastname;
    property borndate: TDictionaryAttribute read Fborndate;
    property documentnr: TDictionaryAttribute read Fdocumentnr;
    property gdpraccept: TDictionaryAttribute read Fgdpraccept;
  end;
  
  TplayingamesTableDictionary = class
  private
    Flastplay: TDictionaryAttribute;
    Fgameuuid: TDictionaryAssociation;
    Fplayeruuid: TDictionaryAssociation;
  public
    constructor Create;
    property lastplay: TDictionaryAttribute read Flastplay;
    property gameuuid: TDictionaryAssociation read Fgameuuid;
    property playeruuid: TDictionaryAssociation read Fplayeruuid;
  end;
  
function Dic: TDicDictionary;

implementation

var
  __Dic: TDicDictionary;

function Dic: TDicDictionary;
begin
  if __Dic = nil then __Dic := TDicDictionary.Create;
  result := __Dic
end;

{ Tplayingames }

function Tplayingames.Getgameuuid: Tgames;
begin
  result := Fgameuuid.Value;
end;

procedure Tplayingames.Setgameuuid(const Value: Tgames);
begin
  Fgameuuid.Value := Value;
end;

function Tplayingames.Getplayeruuid: Tplayers;
begin
  result := Fplayeruuid.Value;
end;

procedure Tplayingames.Setplayeruuid(const Value: Tplayers);
begin
  Fplayeruuid.Value := Value;
end;

{ TDicDictionary }

destructor TDicDictionary.Destroy;
begin
  if Fplayingames <> nil then Fplayingames.Free;
  if Fplayers <> nil then Fplayers.Free;
  if Fgames <> nil then Fgames.Free;
  inherited;
end;

function TDicDictionary.Getgames: TgamesTableDictionary;
begin
  if Fgames = nil then Fgames := TgamesTableDictionary.Create;
  result := Fgames;
end;

function TDicDictionary.Getplayers: TplayersTableDictionary;
begin
  if Fplayers = nil then Fplayers := TplayersTableDictionary.Create;
  result := Fplayers;
end;

function TDicDictionary.Getplayingames: TplayingamesTableDictionary;
begin
  if Fplayingames = nil then Fplayingames := TplayingamesTableDictionary.Create;
  result := Fplayingames;
end;

{ TgamesTableDictionary }

constructor TgamesTableDictionary.Create;
begin
  inherited;
  Fgameuuid := TDictionaryAttribute.Create('gameuuid');
  Ftitle := TDictionaryAttribute.Create('title');
  Fdescription := TDictionaryAttribute.Create('description');
  Fimage := TDictionaryAttribute.Create('image');
end;

{ TplayersTableDictionary }

constructor TplayersTableDictionary.Create;
begin
  inherited;
  Fplayeruuid := TDictionaryAttribute.Create('playeruuid');
  Ffirstname := TDictionaryAttribute.Create('firstname');
  Flastname := TDictionaryAttribute.Create('lastname');
  Fborndate := TDictionaryAttribute.Create('borndate');
  Fdocumentnr := TDictionaryAttribute.Create('documentnr');
  Fgdpraccept := TDictionaryAttribute.Create('gdpraccept');
end;

{ TplayingamesTableDictionary }

constructor TplayingamesTableDictionary.Create;
begin
  inherited;
  Flastplay := TDictionaryAttribute.Create('lastplay');
  Fgameuuid := TDictionaryAssociation.Create('gameuuid');
  Fplayeruuid := TDictionaryAssociation.Create('playeruuid');
end;

initialization
  RegisterEntity(Tgames);
  RegisterEntity(Tplayers);
  RegisterEntity(Tplayingames);

finalization
  if __Dic <> nil then __Dic.Free

end.
