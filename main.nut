// Create a table holding the commands
commands <- [ "players", "health", "armour", "heal", "help", "cash", "protection", "ticket", "clearchat", "shout" ];

// Create a table holding names that cannot be used in game
bannedNames <- [ "Admin", "Administrator" ];

function onPlayerJoin( player )
{
	// Check if the name is banned
	foreach ( name in bannedNames )
	{
		if ( name == player.Name )
		{
			MessagePlayer( "Erro, nome invalido.", player );
			KickPlayer( player );
			return;
		}
		MessagePlayer( "Bem-vindo ao servidor MMO! (Digite !help para ver os comandos)", player );
	}
	
	print( "Player " + player.Name + " joined. [" + player.ID + "]" );
}

function onScriptLoad( )
{
	print( "Script \"Main.nut\" Iniciado com exito." );
}

function onScriptUnload( )
{
	print( "Script \"Main.nut\" Descarregado com exito." );
}

function onPlayerChat( player, text )
{
	local backupText = text;
	local firstChar = backupText.slice( 0, 1 );
	if (  firstChar == "!" )
	{
		// The following function makes any ! commands go to the OnPlayerCommand handler
		local splittext = text.slice( 1 );
		local params = split( splittext, " " );
		if ( params.len() == 1 ) onPlayerCommand( player, params[ 0 ], "" );
		else 
		{
			splittext = splittext.slice( splittext.find( " " ) + 1 );
			onPlayerCommand( player, params[ 0 ], splittext );
		}		
	}
}

function onPlayerCommand( player, cmd, text )
{

	if ( cmd == "commands" )
	{
		local cmdThing = 0;
		local cmdOutput = null;
		if ( commands.len() >= 1 )
		{
			MessagePlayer( "--- Comandos ---", player );
			for ( local id = 0; id < commands.len(); id += 1 )
			{
				if ( cmdThing < 10 )
				{
					if ( cmdOutput ) cmdOutput = cmdOutput + ", " + commands[ id ];
					else cmdOutput = commands[ id ];
				
					cmdThing += 1;
				}
				else
				{
					MessagePlayer( cmdOutput, player );
				
					cmdOutput = "";
					cmdThing = 0;
				}
			}
			
			if ( cmdOutput != "" ) MessagePlayer( cmdOutput, player );
		}
		else MessagePlayer( "Os comandos nao estao disponiveis no momento.", player );			
	}
	
	else if ( cmd == "health" )
	{
		if ( text )
		{
			local a = split( text, " " );
			
			local plr = null;
			if ( !IsNum( a[0] ) ) plr = FindPlayer( a[0] );
			else plr = FindPlayer( a[0].tointeger() );
			
			if ( plr ) MessagePlayer( plr.Name + " tem " + plr.Health + "% de vida.", player );
			else MessagePlayer( "Erro, jogador invalido.", player );
		}
		else MessagePlayer( player.Name + " tem " + player.Health + "% de vida.", player );
	}
	else if ( cmd == "armour" )
	{
		if ( text )
		{
			local a = split( text, " " );
			
			local plr = null;
			if ( !IsNum( a[0] ) ) plr = FindPlayer( a[0] );
			else plr = FindPlayer( a[0].tointeger() );
			
			if ( plr ) MessagePlayer( plr.Name + " tem " + plr.Armour + "% de colete.", player );
			else MessagePlayer( "Erro, jogador invalido.", player );
		}
		else MessagePlayer( player.Name + " tem " + player.Armour + "% de colete.", player );
	}
	
	else if ( cmd == "heal" )
	{
		local health = player.Health;
		if ( health < 100 )
		{
			// calculate the cost based on their health
			local cost = ( ( 425 / 275 ) * ( 300 - health ) );
			if ( player.Cash >= cost )
			{
				player.Cash -= cost;
				player.Health = 100;
				MessagePlayer( "Voce foi curado! (Custo: $" + cost + ")", player );
			}
			else MessagePlayer( "Desculpe, voce nao pode comprar vida neste momento. (Custo: $" + cost + ")", player );
		}
		else MessagePlayer( "Sua vida esta atualmente cheia.", player );
	}
	
    if ( cmd == "help" )
	{
		MessagePlayer( "!ticket=Pegar tickets, !cash=Checar dinheiro, !protection=Comprar colete, !health=Checar vida, !players=Lista de jogadores, ", player );
		MessagePlayer( "!commands=lista de comandos, !help=Topico de ajuda, clearchat=Limpar o chat, !heal=Comprar vida, !shout=Envia uma mensagem de assassinato. ", player );
	}

	if ( cmd == "cash" )
	{
	    if ( text )
		{
			local a = split( text, " " );

			local plr = null;
			if ( !IsNum( a[0] ) ) plr = FindPlayer( a[0] );
			else plr = FindPlayer( a[0].tointeger() );

			if ( plr ) MessagePlayer( plr.Name + " tem " + player.Cash + " de dinheiro.", player );
			else MessagePlayer( "Erro, jogador invalido.", player );
		}
		else MessagePlayer( player.Name + " tem " + player.Cash + " de dinheiro.", player );
	}

    if ( cmd == "protection" )
	{
		local armour = player.Armour;
		if ( armour < 100 )
		{
			// calculate the cost based on their health
			local cost = ( ( 725 / 375 ) * ( 500 - armour ) );
			if ( player.Cash >= cost )
			{
				player.Cash -= cost;
				player.Armour = 100;
				MessagePlayer( "Voce esta protegido! (Custo: $" + cost + ")", player );
			}
			else MessagePlayer( "Desculpe, voce nao pode comprar colete neste momento. (Custo: $" + cost + ")", player );
		}
		else MessagePlayer( "Seu colete esta atualmente cheio.", player );
	}

    if ( cmd == "ticket" )
	{
	 	local cash = player.Cash;
		if ( cash < 30000 )
  		{
			// calculate the cost based on their health
			local cost = ( ( -5 / -5 ) * ( 0 - cash ) );
			if ( player.Cash >= cost )
			{
				player.Cash -= cost;
				player.Cash = 30000;
				MessagePlayer( "Voce pegou tickets!", player );
			}
			else MessagePlayer( "Desculpe, voce nao pode pegar tickets neste momento.", player );
		}
		else MessagePlayer( "Voce nao pode pegar mais tickets!", player );
	}
    
    if ( cmd == "clearchat" )
	{
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
		MessagePlayer( "", player );
	}

    if ( cmd == "shout" )
	{
	    if ( text )
		{
			local a = split( text, " " );

			local plr = null;
			if ( !IsNum( a[0] ) ) plr = FindPlayer( a[0] );
			else plr = FindPlayer( a[0].tointeger() );

			if ( plr ) Message( plr.Name + " voce esta morto!" );
			else MessagePlayer( "Erro, jogador invalido.", player );
		}
		else Message( player.Name + " voce esta morto!" );
	}

	if ( cmd == "players" )
	{
		// Lists a table of players currently in game
		local maxPlayers = GetMaxPlayers();
		local i = 0, ii = 0, iii = 0;
		local buffer = null;
		while ( ( i < maxPlayers ) && ( ii < GetPlayers() ) )
		{
			local plr = FindPlayer( i );
			if ( plr )
			{
				if ( !buffer )
				{
					buffer = plr.Name;
					iii++;
				}
				else if ( ++iii < 3 ) buffer = buffer + "     |     " + plr.Name;
				else
				{
					MessagePlayer( buffer, player );
					buffer = plr.Name;

					iii = 0;
				}

				ii++;
			}

			i++;
		}
		if ( buffer ) MessagePlayer( buffer, player );

		MessagePlayer( "Jogadores: " + GetPlayers(), player );
	}
	
}

function onConsoleInput( cmd, text )
{
	if ( cmd == "players" )
	{
		// Lists a table of players currently in game
		local maxPlayers = GetMaxPlayers();
		local i = 0, ii = 0, iii = 0;
		local buffer = null;
		while ( ( i < maxPlayers ) && ( ii < GetPlayers() ) )
		{
			local plr = FindPlayer( i );
			if ( plr )
			{
				if ( !buffer ) 
				{
					buffer = plr.Name;
					iii++;
				}
				else if ( ++iii < 3 ) buffer = buffer + "     |     " + plr.Name;
				else
				{
					print( buffer );
					buffer = plr.Name;
					
					iii = 0;
				}
				
				ii++;
			}
			
			i++;
		}
		if ( buffer ) print( buffer );
		
		print( "Jogadores: " + GetPlayers() );
	}
}
