extension FormDataEncoder {
    struct Encoder {
        let codingPath: [any CodingKey]
        let storage = Storage()
        let userInfo: [CodingUserInfoKey: Any]
    }
}

extension FormDataEncoder.Encoder: Encoder {
    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        let container = FormDataEncoder.KeyedContainer<Key>(encoder: self)
        storage.dataContainer = container.dataContainer
        return .init(container)
    }

    func unkeyedContainer() -> any UnkeyedEncodingContainer {
        let container = FormDataEncoder.UnkeyedContainer(encoder: self)
        storage.dataContainer = container.dataContainer
        return container
    }

    func singleValueContainer() -> any SingleValueEncodingContainer {
        self
    }
}

extension FormDataEncoder.Encoder {
    func nested(at key: any CodingKey) -> FormDataEncoder.Encoder {
        .init(codingPath: codingPath + [key], userInfo: userInfo)
    }
}
