#language: ru

Функционал: <описание фичи>

Как ci-bot и ввожу пароль 123
Я хочу <описание функционала>
Чтобы <бизнес-эффект>

Контекст:
	Дано Я подключаю клиент тестирования с параметрами:
    | 'Имя подключения' | 'Имя компьютера' | 'Порт' | 'Строка соединения' | 'Логин'      | 'Пароль'     | 'Тип клиента'| 'Запускаемая обработка' |  'Дополнительные параметры строки запуска'  |
    | 'Test 1'          | 'localhost'      | '1541' | ''                  | 'ci-bot'     | '123'  		| 'Тонкий'     |                         |                                             |


Сценарий: <описание сценария>

	Когда Я нажимаю кнопку командного интерфейса 'Справочники'
	И Я нажимаю кнопку командного интерфейса "Контрагенты"
	Тогда открылось окно 'Контрагенты'
	И Я закрываю окно 'Контрагенты'
