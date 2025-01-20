@startuml
package "Negociação de Conflitos" {
	[Fundamentos da Negociação] --> [Definição]

	note right of [Definição]
	Negociação é um processo em que duas ou mais partes,com interesses
	comuns e antagônicos, se reúnem para confrontar e discutir propostas
	explícitas com o objetivo de alcançar um acordo.
	end note

	[Fundamentos da Negociação] --> [Tipos]

	[Tipos] --> [Integrativa]

	note left of [Integrativa]
	"Fazer o bolo crescer"
	end note
	
	[Tipos] --> [Distributiva]

	note right of [Distributiva]
	"Bolo fixo"
	end note

	
}
@enduml
